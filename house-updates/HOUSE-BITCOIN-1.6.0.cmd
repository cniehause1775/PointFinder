@echo off
setlocal
set "HOUSE_SELF=%~f0"
set "HOUSE_PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if exist "%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\powershell.exe" set "HOUSE_PS=%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\powershell.exe"
if not exist "%HOUSE_PS%" (
  echo HOUSE needs the built-in Windows PowerShell to finish this update.
  pause
  exit /b 1
)
start "" "%HOUSE_PS%" -NoLogo -NoProfile -STA -WindowStyle Hidden -Command "$ErrorActionPreference='Stop';try{$t=[IO.File]::ReadAllText($env:HOUSE_SELF);$m='# HOUSE'+'-POWERSHELL-START';$i=$t.IndexOf($m,[StringComparison]::Ordinal);if($i -lt 0){throw 'Update source marker missing.'};& ([scriptblock]::Create($t.Substring($i+$m.Length)))}catch{Add-Type -AssemblyName System.Windows.Forms;[void][System.Windows.Forms.MessageBox]::Show($_.Exception.Message,'HOUSE update')}"
exit /b

# HOUSE-POWERSHELL-START
$ErrorActionPreference = 'Stop';
$script:HouseVersion = '1.6.0';

function Get-HouseBootstrapSha256([byte[]]$Bytes) {
    $sha=[Security.Cryptography.SHA256]::Create();
    try { return ([BitConverter]::ToString($sha.ComputeHash($Bytes))).Replace('-','').ToLowerInvariant(); }
    finally { $sha.Dispose(); }
}

function Get-HouseBootstrapClient {
    Add-Type -AssemblyName System.Net.Http;
    $handler=[Net.Http.HttpClientHandler]::new();
    $handler.AllowAutoRedirect=$false;
    $client=[Net.Http.HttpClient]::new($handler);
    $client.Timeout=[timespan]::FromSeconds(30);
    $client.MaxResponseContentBufferSize=65536;
    $client.DefaultRequestHeaders.UserAgent.ParseAdd('HouseBitcoinDeskBootstrap/1.6.0');
    return [pscustomobject]@{Client=$client;Handler=$handler};
}

function Get-HouseBootstrapPart($Client,[string]$Base,$Part) {
    if ($Part.Name -cnotmatch '^part-\d{3}\.b64$' -or $Part.Sha256 -cnotmatch '^[a-f0-9]{64}$' -or
        [long]$Part.Bytes -lt 1 -or [long]$Part.Bytes -gt 65536) { throw 'The signed update chunk record is invalid.'; }
    $url=$Base+$Part.Name;
    $uri=$null;
    if (-not [uri]::TryCreate($url,[UriKind]::Absolute,[ref]$uri) -or $uri.Scheme -cne 'https' -or
        $uri.Host -cne 'raw.githubusercontent.com' -or $uri.Port -ne 443 -or $uri.UserInfo -or
        $uri.Query -or $uri.Fragment -or $uri.OriginalString.Contains('%') -or
        $uri.AbsolutePath -cnotmatch '^/cniehause1775/PointFinder/main/house-updates/parts/1\.6\.0/part-\d{3}\.b64$') {
        throw 'The update chunk address is outside the trusted release location.';
    }
    $response=$null;
    try {
        $response=$Client.GetAsync($uri.AbsoluteUri,[Net.Http.HttpCompletionOption]::ResponseContentRead).GetAwaiter().GetResult();
        if ([int]$response.StatusCode -ne 200) { throw ('The update server returned HTTP '+[int]$response.StatusCode+'.'); }
        $text=$response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
        if ($text.Length -lt 4 -or $text.Length -gt 50000 -or $text -cnotmatch '^[A-Za-z0-9+/=\r\n]+$') {
            throw 'An update chunk was not valid base64 text.';
        }
        $bytes=[Convert]::FromBase64String(($text -replace '\s',''));
        if ($bytes.LongLength -ne [long]$Part.Bytes -or (Get-HouseBootstrapSha256 $bytes) -cne [string]$Part.Sha256) {
            throw 'An update chunk did not match its pinned size and checksum.';
        }
        return $bytes;
    } finally { if ($null -ne $response) { $response.Dispose(); } }
}

function Test-HouseReconstructedApp([byte[]]$Bytes) {
    if ($null -eq $Bytes -or $Bytes.LongLength -ne 428178 -or
        (Get-HouseBootstrapSha256 $Bytes) -cne 'fbfad0202692b12858af810bcac06a02c59110373fc6ca00386a33b89408a16e') {
        throw 'The reconstructed HOUSE app did not match the signed release.';
    }
    $utf8=[Text.UTF8Encoding]::new($false,$true);
    $text=$utf8.GetString($Bytes);
    $marker='# HOUSE'+'-POWERSHELL-START';
    if (-not $text.StartsWith('@echo off',[StringComparison]::OrdinalIgnoreCase) -or
        $text.IndexOf($marker,[StringComparison]::Ordinal) -lt 0 -or
        $text.IndexOf($marker,[StringComparison]::Ordinal) -ne $text.LastIndexOf($marker,[StringComparison]::Ordinal) -or
        $text -cnotmatch ('(?m)^\$script:HouseVersion\s*=\s*''1\.6\.0''\s*;?\s*\r?$')) {
        throw 'The reconstructed file is not HOUSE 1.6.0.';
    }
    $source=$text.Substring($text.IndexOf($marker,[StringComparison]::Ordinal)+$marker.Length);
    $tokens=$null; $errors=$null;
    [void][Management.Automation.Language.Parser]::ParseInput($source,[ref]$tokens,[ref]$errors);
    if ($errors.Count -gt 0) { throw 'The reconstructed HOUSE code did not pass its syntax check.'; }
}

function Start-HouseReconstructedApp([string]$Target) {
    $info=[Diagnostics.ProcessStartInfo]::new();
    $info.FileName=Join-Path $PSHOME 'powershell.exe';
    $loader='$ErrorActionPreference=''Stop'';$t=[IO.File]::ReadAllText($env:HOUSE_SELF);$m=''# HOUSE''+''-POWERSHELL-START'';$i=$t.IndexOf($m,[StringComparison]::Ordinal);if($i -lt 0){throw ''App source marker missing.''};& ([scriptblock]::Create($t.Substring($i+$m.Length)))';
    $info.Arguments='-NoLogo -NoProfile -STA -WindowStyle Hidden -Command "'+$loader+'"';
    $info.WorkingDirectory=[IO.Path]::GetDirectoryName($Target);
    $info.UseShellExecute=$false; $info.CreateNoWindow=$true;
    $info.EnvironmentVariables['HOUSE_MODE']='APP';
    $info.EnvironmentVariables['HOUSE_SELF']=$Target;
    return [Diagnostics.Process]::Start($info);
}

$target=[IO.Path]::GetFullPath($(if ([string]::IsNullOrWhiteSpace($env:HOUSE_SELF)) {
    Join-Path (Join-Path $env:LOCALAPPDATA 'HouseBitcoinDesk') 'HOUSE-BITCOIN.cmd'
} else { $env:HOUSE_SELF }));
$expectedRoot=[IO.Path]::GetFullPath((Join-Path $env:LOCALAPPDATA 'HouseBitcoinDesk'));
if ([IO.Path]::GetDirectoryName($target) -ine $expectedRoot -or [IO.Path]::GetFileName($target) -ine 'HOUSE-BITCOIN.cmd') {
    throw 'HOUSE refused to install outside its normal Local AppData folder.';
}
[void][IO.Directory]::CreateDirectory($expectedRoot);
$parts=@(
    [pscustomobject]@{Name='part-001.b64';Bytes=25374;Sha256='2a2b4dea0240a31cafc34073bf35d8f5cb75d5486d96eea9a43314e7e4f775f6'},
    [pscustomobject]@{Name='part-002.b64';Bytes=25374;Sha256='5ce2e37d4b09cf3ff9e7d2445629ac6e860bee5436f7ec35e1f15826677c6de1'},
    [pscustomobject]@{Name='part-003.b64';Bytes=25374;Sha256='5e38937ce8e36a04699b40c0bdfd839072e5e4420081d738e4d6391d4f42dbf5'},
    [pscustomobject]@{Name='part-004.b64';Bytes=6343;Sha256='087126fdb0ceb6a7bbac7530fb880378480020e3eb2c231d840c884d4e73a3ad'},
    [pscustomobject]@{Name='part-005.b64';Bytes=6343;Sha256='85e650065a1db21c82d8f9d57e72660a7b9cb44375815d5f62818d0b6fe49939'},
    [pscustomobject]@{Name='part-006.b64';Bytes=6343;Sha256='d2c037fd77243402e40bb3834d7790b2b0c9d2d5e0513f0e64ba330472ddb83e'},
    [pscustomobject]@{Name='part-007.b64';Bytes=6343;Sha256='1ff43bc9788eb1f8686beb4e61385ee268edd7343ff0328e318406757eb7c486'}
);
$base='https://raw.githubusercontent.com/cniehause1775/PointFinder/main/house-updates/parts/1.6.0/';
$bundle=Get-HouseBootstrapClient;
$compressed=[IO.MemoryStream]::new();
$stage=$target+'.reconstructed-'+[guid]::NewGuid().ToString('N');
$backup=$target+'.bootstrap-'+[guid]::NewGuid().ToString('N');
$started=$null;
try {
    foreach ($part in $parts) {
        $bytes=Get-HouseBootstrapPart $bundle.Client $base $part;
        $compressed.Write($bytes,0,$bytes.Length);
    }
    $gzipBytes=$compressed.ToArray();
    if ($gzipBytes.LongLength -ne 101494 -or (Get-HouseBootstrapSha256 $gzipBytes) -cne '761aa05417a180d6bd8e62e659a47e0999263a0a95521fab6bf933b6d5b3e3bf') {
        throw 'The complete compressed update did not match its pinned checksum.';
    }
    $input=[IO.MemoryStream]::new($gzipBytes,$false);
    $output=[IO.MemoryStream]::new();
    try {
        $zip=[IO.Compression.GZipStream]::new($input,[IO.Compression.CompressionMode]::Decompress);
        try { $zip.CopyTo($output); } finally { $zip.Dispose(); }
        $appBytes=$output.ToArray();
    } finally { $output.Dispose(); $input.Dispose(); }
    Test-HouseReconstructedApp $appBytes;
    [IO.File]::WriteAllBytes($stage,$appBytes);
    Test-HouseReconstructedApp ([IO.File]::ReadAllBytes($stage));
    if ([IO.File]::Exists($target)) {
        [IO.File]::Replace($stage,$target,$backup,$true);
    } else {
        [IO.File]::Move($stage,$target);
    }
    Test-HouseReconstructedApp ([IO.File]::ReadAllBytes($target));
    $started=Start-HouseReconstructedApp $target;
    if ($null -eq $started) { throw 'Windows did not start the reconstructed HOUSE app.'; }
    if (-not [string]::IsNullOrWhiteSpace($env:HOUSE_UPDATE_ACK)) {
        $deadline=[datetime]::UtcNow.AddSeconds(35);
        $ready=$false;
        while ([datetime]::UtcNow -lt $deadline) {
            if ([IO.File]::Exists($env:HOUSE_UPDATE_ACK)) {
                try {
                    $notice=[IO.File]::ReadAllText($env:HOUSE_UPDATE_ACK) | ConvertFrom-Json;
                    if ($notice.nonce -ceq $env:HOUSE_UPDATE_NONCE -and $notice.version -ceq '1.6.0') { $ready=$true; break; }
                } catch { }
            }
            if ($started.HasExited) { break; }
            [Threading.Thread]::Sleep(200);
        }
        if (-not $ready) { throw 'HOUSE 1.6.0 did not finish opening after reconstruction.'; }
    }
    if ([IO.File]::Exists($backup)) { [IO.File]::Delete($backup); }
} catch {
    if ($null -ne $started) { try { if (-not $started.HasExited) { $started.Kill(); } } catch { } }
    if ([IO.File]::Exists($backup)) {
        try {
            $restore=$target+'.restore-'+[guid]::NewGuid().ToString('N');
            [IO.File]::Copy($backup,$restore,$false);
            if ([IO.File]::Exists($target)) { $failed=$target+'.failed-'+[guid]::NewGuid().ToString('N'); [IO.File]::Replace($restore,$target,$failed,$true); if ([IO.File]::Exists($failed)) { [IO.File]::Delete($failed); }; }
            else { [IO.File]::Move($restore,$target); }
        } catch { }
    }
    throw;
} finally {
    if ($null -ne $started) { $started.Dispose(); }
    if ($null -ne $bundle) {
        try { $bundle.Client.Dispose(); } catch { }
        try { $bundle.Handler.Dispose(); } catch { }
    }
    $compressed.Dispose();
    foreach ($path in @($stage,$backup)) { if ([IO.File]::Exists($path)) { try { [IO.File]::Delete($path); } catch { } } }
}
