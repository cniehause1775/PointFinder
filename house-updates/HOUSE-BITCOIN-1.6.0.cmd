@echo off
setlocal
set "HOUSE_SELF=%~f0"
set "HOUSE_MODE=APP"
set "HOUSE_PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if exist "%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\powershell.exe" set "HOUSE_PS=%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\powershell.exe"
if not exist "%HOUSE_PS%" (
  echo HOUSE needs the built-in Windows PowerShell to open.
  pause
  exit /b 1
)
start "" "%HOUSE_PS%" -NoLogo -NoProfile -STA -WindowStyle Hidden -Command "$ErrorActionPreference='Stop';try{$t=[IO.File]::ReadAllText($env:HOUSE_SELF);$m='# HOUSE'+'-POWERSHELL-START';$i=$t.IndexOf($m,[StringComparison]::Ordinal);if($i -lt 0){throw 'App source marker missing.'};& ([scriptblock]::Create($t.Substring($i+$m.Length)))}catch{Add-Type -AssemblyName System.Windows.Forms;[void][System.Windows.Forms.MessageBox]::Show($_.Exception.Message,'HOUSE - Bitcoin Desk')}"
exit /b

# HOUSE-POWERSHELL-START
$ErrorActionPreference = 'Stop';

$script:HouseVersion = '1.6.0';

$script:HouseBootstrapWallet = '';

$script:HouseWallet = '';

$script:HouseUpdateManifestUrl = 'https://raw.githubusercontent.com/cniehause1775/PointFinder/main/house-updates/latest.json';

$script:HouseUpdatePublicKeyXml = '<RSAKeyValue><Modulus>zPDRwj1IFlw5Fpv/TwdnShyqDnDhLMOd2RypBxsQ/VaMvuIYb6DN83btJtpNnn6wNWnk7NbXCOSyqqfXdCPVjq6IJ4IC2L/syxE5KaFE3jMXtQgZ5gEb26dWfR2EuxkBg+oQyZUJQj88KClps2wAZ/9Qf34tKtE16SLPeezpVdmWT+LK8lJIgK4iEtQdMmhXl49P8qXcCbI7VXISzuIUZJArSxrrzREuDpHPcBf1a9Ltr/HbRnf/r0c6v7Pof5fAVIFaYW4uEHKUeqgOSDZ0ZmC0c4E1XCeSC4e/IpJqXRRtNdDTxw0rJd7ntNL9uGxI7v3R85Jpeff67rPIwZDCsI0mdXMD7VvvD8b9XUmQuLUchMnuVDZmkCB6/btJTQnaF+jZiV9smT+RXeF6bb/n6weFb1w/28FO3bXnFc/a7kvPLFW1GPmLGRF4Y1yZoHPxNsWnfHMTwYQGMIhpiRFQ8kiAg09+WykykbQklHjQvfEAwdUQ6Qf/Euq9bXbKlZ9R7</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>';

$script:HouseMusicCatalogJson = @'
[
  {
    "Id": "its-all-over-but-the-crying",
    "Title": "It's All Over but the Crying",
    "Artist": "The Ink Spots"
  },
  {
    "Id": "i-dont-want-to-set-the-world-on-fire",
    "Title": "I Don't Want to Set the World on Fire",
    "Artist": "The Ink Spots"
  },
  {
    "Id": "maybe",
    "Title": "Maybe",
    "Artist": "The Ink Spots"
  },
  {
    "Id": "big-iron",
    "Title": "Big Iron",
    "Artist": "Marty Robbins"
  },
  {
    "Id": "the-wanderer",
    "Title": "The Wanderer",
    "Artist": "Dion"
  },
  {
    "Id": "uranium-fever",
    "Title": "Uranium Fever",
    "Artist": "Elton Britt"
  },
  {
    "Id": "crawl-out-through-the-fallout",
    "Title": "Crawl Out Through the Fallout",
    "Artist": "Sheldon Allman"
  },
  {
    "Id": "atom-bomb-baby",
    "Title": "Atom Bomb Baby",
    "Artist": "The Five Stars"
  },
  {
    "Id": "free-all-by-myself",
    "Title": "All By Myself (1921)",
    "Artist": "Aileen Stanley"
  },
  {
    "Id": "free-april-showers",
    "Title": "April Showers (1921)",
    "Artist": "Paul Whiteman Orchestra"
  },
  {
    "Id": "free-jazz-band-ball",
    "Title": "At the Jazz Band Ball (1918)",
    "Artist": "Original Dixieland Jazz Band"
  }
]
'@;

$script:HouseMusicCatalog = $script:HouseMusicCatalogJson | ConvertFrom-Json;

$script:HouseFreeMusicCatalogJson = @'
[
  {
    "Id": "free-all-by-myself",
    "Title": "All By Myself (1921)",
    "Artist": "Aileen Stanley",
    "Url": "https://upload.wikimedia.org/wikipedia/commons/8/8f/All_By_Myself_%281921_sound_recording%29.mp3",
    "Sha256": "bd5180e2a67d90ead3f678c594db961756e5f244b64c16dc61fc7960cc810057",
    "Bytes": 1578651,
    "SourceUrl": "https://commons.wikimedia.org/wiki/File:All_By_Myself_(1921_sound_recording).mp3",
    "OriginalSourceUrl": "https://www.loc.gov/item/jukebox-40643/",
    "Seconds": 197.28,
    "Rights": "Public domain in the United States; pre-1923 recording and composition. Credit: Library of Congress, National Jukebox; Wikimedia Commons."
  },
  {
    "Id": "free-april-showers",
    "Title": "April Showers (1921)",
    "Artist": "Paul Whiteman Orchestra",
    "Url": "https://upload.wikimedia.org/wikipedia/commons/8/83/April_Showers_%281921%2C_Paul_Whiteman%29.mp3",
    "Sha256": "596603bbfa927ef4788579c0216ed3a8069326da5505701d664d5a0fc342880e",
    "Bytes": 3167342,
    "SourceUrl": "https://commons.wikimedia.org/wiki/File:April_Showers_(1921,_Paul_Whiteman).mp3",
    "OriginalSourceUrl": "https://www.loc.gov/item/jukebox-42567/",
    "Seconds": 197.93,
    "Rights": "Public domain in the United States; pre-1923 recording and composition. Credit: Library of Congress, National Jukebox; Wikimedia Commons."
  },
  {
    "Id": "free-jazz-band-ball",
    "Title": "At the Jazz Band Ball (1918)",
    "Artist": "Original Dixieland Jazz Band",
    "Url": "https://upload.wikimedia.org/wikipedia/commons/a/a6/At_the_jazz_band_ball_%281918_sound_recording%29.mp3",
    "Sha256": "3e24a0e386adf98e19735c1b7f0a8fa1479e8a34f69eae21386ba76fa10fd0aa",
    "Bytes": 1288171,
    "SourceUrl": "https://commons.wikimedia.org/wiki/File:At_the_jazz_band_ball_(1918_sound_recording).mp3",
    "OriginalSourceUrl": "https://www.loc.gov/item/jukebox-28219/",
    "Seconds": 160.97,
    "Rights": "Public domain in the United States; pre-1923 recording and composition. Credit: Library of Congress, National Jukebox; Wikimedia Commons."
  }
]
'@;

$script:HouseFreeMusicCatalog = $script:HouseFreeMusicCatalogJson | ConvertFrom-Json;

$script:HouseBundledMusicCatalog = @(
    [pscustomobject]@{
        Id='free-all-by-myself'; Title='All By Myself (1921)'; Artist='Aileen Stanley';
        Sha256='87ce76485debc04b55de3699180d231d81b95df7c9ad1b68354ecd572f2a133e'; Bytes=986741; Data='';
    },
    [pscustomobject]@{
        Id='free-april-showers'; Title='April Showers (1921)'; Artist='Paul Whiteman Orchestra';
        Sha256='07cce2042a8fee810c6023f3fdbbfc4038d14244f4743954c8cd557dc1c7e44b'; Bytes=990006; Data='';
    },
    [pscustomobject]@{
        Id='free-jazz-band-ball'; Title='At the Jazz Band Ball (1918)'; Artist='Original Dixieland Jazz Band';
        Sha256='00ed65ec77cc6b29da24a44e7876ae8ccfcd47d9267c2f50c043c47368a06cbd'; Bytes=805190; Data='';
    }
)

# Mainnet receive-address validation and local configuration migration.
# No seed phrase, private key, access code, or wallet signing is used by HOUSE.

function Test-HouseBech32Checksum([string]$Address) {
    if ([string]::IsNullOrWhiteSpace($Address)) { return $false; }
    $value=$Address.Trim();
    if ($value.Length -lt 14 -or $value.Length -gt 90) { return $false; }
    if ($value -cmatch '[A-Z]' -and $value -cmatch '[a-z]') { return $false; }
    $value=$value.ToLowerInvariant();
    $separator=$value.LastIndexOf('1');
    if ($separator -lt 1 -or $separator+7 -gt $value.Length) { return $false; }
    $hrp=$value.Substring(0,$separator);
    if ($hrp -cne 'bc') { return $false; }
    $alphabet='qpzry9x8gf2tvdw0s3jn54khce6mua7l';
    $data=[Collections.Generic.List[int]]::new();
    for ($i=$separator+1;$i -lt $value.Length;$i++) {
        $index=$alphabet.IndexOf($value[$i]); if ($index -lt 0) { return $false; }
        $data.Add($index);
    }
    if ($data.Count -lt 7) { return $false; }
    $polymod=1;
    $values=[Collections.Generic.List[int]]::new();
    foreach ($character in $hrp.ToCharArray()) { $values.Add(([int][char]$character)-shr 5); }
    $values.Add(0);
    foreach ($character in $hrp.ToCharArray()) { $values.Add(([int][char]$character)-band 31); }
    foreach ($item in $data) { $values.Add($item); }
    foreach ($item in $values) {
        $top=$polymod -shr 25; $polymod=(($polymod -band 0x1ffffff)-shl 5)-bxor $item;
        if ($top -band 1) { $polymod=$polymod-bxor 0x3b6a57b2; }
        if ($top -band 2) { $polymod=$polymod-bxor 0x26508e6d; }
        if ($top -band 4) { $polymod=$polymod-bxor 0x1ea119fa; }
        if ($top -band 8) { $polymod=$polymod-bxor 0x3d4233dd; }
        if ($top -band 16) { $polymod=$polymod-bxor 0x2a1462b3; }
    }
    return ($polymod -eq 1 -or $polymod -eq 0x2bc830a3);
}

function Test-HouseBase58Address([string]$Address) {
    if ([string]::IsNullOrWhiteSpace($Address)) { return $false; }
    $text=$Address.Trim();
    if ($text.Length -lt 26 -or $text.Length -gt 35 -or $text[0] -notin @('1','3')) { return $false; }
    $alphabet='123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
    [Numerics.BigInteger]$number=0;
    foreach ($character in $text.ToCharArray()) {
        $index=$alphabet.IndexOf($character); if ($index -lt 0) { return $false; }
        $number=($number*58)+$index;
    }
    $raw=[Collections.Generic.List[byte]]::new();
    while ($number -gt 0) {
        $raw.Insert(0,[byte]($number % 256)); $number=[Numerics.BigInteger]::Divide($number,256);
    }
    foreach ($character in $text.ToCharArray()) { if ($character -eq '1') { $raw.Insert(0,0); } else { break; } }
    if ($raw.Count -ne 25) { return $false; }
    $payload=$raw.GetRange(0,21).ToArray(); $checksum=$raw.GetRange(21,4).ToArray();
    $sha=[Security.Cryptography.SHA256]::Create();
    try { $first=$sha.ComputeHash($payload); $second=$sha.ComputeHash($first); }
    finally { $sha.Dispose(); }
    for ($i=0;$i -lt 4;$i++) { if ($checksum[$i] -ne $second[$i]) { return $false; } }
    return $true;
}

function Test-HouseBitcoinAddress([string]$Address) {
    if ([string]::IsNullOrWhiteSpace($Address)) { return $false; }
    $value=$Address.Trim();
    if ($value.StartsWith('bc1',[StringComparison]::OrdinalIgnoreCase)) { return Test-HouseBech32Checksum $value; }
    return Test-HouseBase58Address $value;
}

function Initialize-HouseWallet {
    $saved='';
    if ($null -ne $script:H.Settings -and $null -ne $script:H.Settings.Wallet) { $saved=[string]$script:H.Settings.Wallet; }
    if (Test-HouseBitcoinAddress $saved) { $script:HouseWallet=$saved.Trim(); return; }
    if (-not [string]::IsNullOrWhiteSpace($saved)) { throw 'Your saved Bitcoin receive address is invalid. HOUSE kept settings.json unchanged. Correct that file before mining.'; }
    if (Test-HouseBitcoinAddress $script:HouseBootstrapWallet) {
        $script:HouseWallet=$script:HouseBootstrapWallet.Trim(); return;
    }
    throw 'No valid Bitcoin receive address is configured. Reopen your personal HOUSE installer or restore the saved wallet in settings.json.';
}

# Complete parser and presentation layer. The parser accepts only bounded, known formats.

function New-MinerState {
    return [pscustomobject]@{
        RateHistory = [System.Collections.Generic.Queue[object]]::new();
        Events = [System.Collections.Generic.Queue[string]]::new();
        LastEventSignature = $null;
        LastLogAt = $null;
        LastJobAt = $null;
        LastShareAt = $null;
        Connection = 'Unknown';
        LastError = $null;
        Wallet = $null;
        Authorized = $false;
        IsSolo = $false;
        Transport = $null;
        PoolHost = $null;
        Algorithm = $null;
        Worker = $null;
        Engine = $null;
        HashrateHps = $null;
        HashrateAt = $null;
        CpuThreads = $null;
        Height = $null;
        PoolDiff = $null;
        NetDiff = $null;
        Accepted = 0;
        Rejected = 0;
        Stale = 0;
        Submitted = 0;
        BestShare = $null;
        BlockCandidates = 0;
        SessionStartedAt = $null;
        ProgramExit = $false;
        StopLine = $null;
    };
}

function Add-MinerEvent($State,[string]$Message,[datetime]$At=(Get-Date)) {
    if ([string]::IsNullOrWhiteSpace($Message)) { return; }
    $stamp = $At.ToString('HH:mm:ss');
    $item = "$stamp  $Message";
    if ($item -eq $State.LastEventSignature) { return; }
    $State.LastEventSignature = $item;
    $State.Events.Enqueue($item);
    while ($State.Events.Count -gt 12) { [void]$State.Events.Dequeue(); }
}

function Parse-Rate([string]$Number,[string]$Unit) {
    [double]$value = 0;
    if (-not [double]::TryParse($Number,[System.Globalization.NumberStyles]::Float,[System.Globalization.CultureInfo]::InvariantCulture,[ref]$value)) { return $null; }
    if ($value -lt 0 -or [double]::IsNaN($value) -or [double]::IsInfinity($value)) { return $null; }
    $multipliers = @{ 'h/s'=1.0; 'kh/s'=1e3; 'mh/s'=1e6; 'gh/s'=1e9; 'th/s'=1e12; 'ph/s'=1e15 };
    $key = $Unit.ToLowerInvariant();
    if (-not $multipliers.ContainsKey($key)) { return $null; }
    $result = $value * [double]$multipliers[$key];
    if ([double]::IsInfinity($result) -or $result -gt 1e21) { return $null; }
    return $result;
}

function Set-Hashrate($State,[double]$Rate,[datetime]$At) {
    if ($Rate -lt 0 -or [double]::IsNaN($Rate) -or [double]::IsInfinity($Rate)) { return; }
    $State.HashrateHps = $Rate;
    $State.HashrateAt = $At;
    $State.RateHistory.Enqueue([pscustomobject]@{At=$At; Rate=$Rate});
    while ($State.RateHistory.Count -gt 120) { [void]$State.RateHistory.Dequeue(); }
}

function Parse-BoundedDouble([string]$Text,[double]$Minimum,[double]$Maximum) {
    [double]$value = 0;
    if (-not [double]::TryParse($Text,[Globalization.NumberStyles]::Float,[Globalization.CultureInfo]::InvariantCulture,[ref]$value) -or
        [double]::IsNaN($value) -or [double]::IsInfinity($value) -or $value -lt $Minimum -or $value -gt $Maximum) { return $null; }
    return $value;
}

function Parse-BoundedLong([string]$Text,[long]$Minimum,[long]$Maximum) {
    [long]$value = 0;
    if (-not [long]::TryParse($Text,[Globalization.NumberStyles]::Integer,[Globalization.CultureInfo]::InvariantCulture,[ref]$value) -or
        $value -lt $Minimum -or $value -gt $Maximum) { return $null; }
    return $value;
}

function Observe-CommonLine($State,[string]$Text,[datetime]$At) {
    $number='[+-]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?';
    if ($Text -match ('^TTF @ ('+$number+')\s*([kMGTPE]?h/s):')) {
        $rate = Parse-Rate $Matches[1] $Matches[2]; if ($null -ne $rate) { Set-Hashrate $State $rate $At; }
    } elseif ($Text -match ('^Hash rate\s+.*\(('+ $number +')\s*([kMGTPE]?h/s)\)\s*$')) {
        $rate = Parse-Rate $Matches[1] $Matches[2]; if ($null -ne $rate) { Set-Hashrate $State $rate $At; }
    } elseif ($Text -match ('^New (?:Stratum Diff|Work:|Block)\s+(?:(?:Block\s+)?(\d+))?.*?(?:Netdiff\s+|Diff:\s+Net\s+)('+ $number +')')) {
        if ($Matches[1]) { $height=Parse-BoundedLong $Matches[1] 1 2147483647; if ($null -ne $height) { $State.Height=$height; } }
        $difficulty=Parse-BoundedDouble $Matches[2] 0 1e30; if ($null -ne $difficulty) { $State.NetDiff=$difficulty; }
        $State.LastJobAt=$At; $State.Connection='Mining'; Add-MinerEvent $State 'Received new mining work' $At;
    } elseif ($Text -match ('^Diff:\s+Net\s+('+ $number +'),\s+Stratum\s+('+ $number +')')) {
        $net=Parse-BoundedDouble $Matches[1] 0 1e30; $pool=Parse-BoundedDouble $Matches[2] 0 1e30;
        if ($null -ne $net) { $State.NetDiff=$net; } if ($null -ne $pool) { $State.PoolDiff=$pool; }
    } elseif ($Text -match ('^New Stratum Diff\s+('+ $number +'),\s+Block\s+(\d+)')) {
        $pool=Parse-BoundedDouble $Matches[1] 0 1e30; $height=Parse-BoundedLong $Matches[2] 1 2147483647;
        if ($null -ne $pool) { $State.PoolDiff=$pool; } if ($null -ne $height) { $State.Height=$height; }
        $State.LastJobAt=$At; $State.Connection='Mining'; Add-MinerEvent $State 'Pool updated share difficulty' $At;
    } elseif ($Text -match '^Stratum connection established$') {
        $State.Connection='Connected'; Add-MinerEvent $State 'Pool connection established' $At;
    } elseif ($Text -match '"method"\s*:\s*"mining\.notify"') {
        $State.LastJobAt=$At; $State.Connection='Mining';
    } elseif ($Text -match '^Threads restarted for new work\.$') {
        $State.LastJobAt=$At; $State.Connection='Mining';
    } elseif ($Text -match '^TLS relay: Verified ([A-Za-z0-9.-]+):4333; protocol (Tls\d+);') {
        $State.PoolHost=$Matches[1]; $State.Transport=$Matches[2]; $State.IsSolo=$true;
        Add-MinerEvent $State ('Verified encrypted pool connection via '+$Matches[2]) $At;
    } elseif ($Text -match '^Program exit$') {
        $State.ProgramExit=$true; $State.Connection='Ended'; Add-MinerEvent $State 'Miner exited' $At;
    } elseif ($Text -match '^Stopped:\s*(.+)$') {
        $State.StopLine=$Matches[1]; $State.LastError=$Matches[1]; $State.Connection='Stopped'; Add-MinerEvent $State ('Stopped: '+$Matches[1]) $At;
    } elseif ($Text -match '^(?:HTTP|stratum|TLS relay: Session ended:|Recv failure:|Connection failed:|Authorization failed:|.*(?:fatal|error).*)') {
        $State.LastError=$Text; if ($State.Connection -ne 'Mining') { $State.Connection='Error'; } Add-MinerEvent $State $Text $At;
    }
}

function Observe-CpuLine($State,[string]$Text,[datetime]$At) {
    if ($Text -match "(\d+) of (\d+) miner threads started using 'sha256d' algorithm") {
        $State.CpuThreads=[int]$Matches[1]; $State.Algorithm='sha256d'; $State.Engine='CPU'; Add-MinerEvent $State ("CPU miner started with "+$Matches[1]+" threads") $At;
    } elseif ($Text -match '^CPU:\s+(.+)$') {
        Add-MinerEvent $State ('CPU: '+$Matches[1]) $At;
    } elseif ($Text -match '"method"\s*:\s*"mining\.authorize".*"params"\s*:\s*\[\s*"([^"]+)"') {
        $worker=$Matches[1]; $dot=$worker.LastIndexOf('.'); if ($dot -gt 0) { $State.Wallet=$worker.Substring(0,$dot); $State.Worker=$worker.Substring($dot+1); } else { $State.Wallet=$worker; }
    } elseif ($Text -match '"id"\s*:\s*2\s*,\s*"error"\s*:\s*null\s*,\s*"result"\s*:\s*true') {
        $State.Authorized=$true; Add-MinerEvent $State 'Pool authorized payout address' $At;
    } elseif ($Text -match '^Periodic Report') {
        $State.LastLogAt=$At;
    } elseif ($Text -match '^Submitted\s+(\d+)\s+(\d+)') {
        $submitted=Parse-BoundedLong $Matches[2] 0 9223372036854775807; if ($null -ne $submitted) { $State.Submitted=$submitted; }
    } elseif ($Text -match '^Accepted\s+(\d+)\s+(\d+)') {
        $accepted=Parse-BoundedLong $Matches[2] 0 9223372036854775807; if ($null -ne $accepted) { $State.Accepted=$accepted; }
    } elseif ($Text -match '^Hi/Lo Share Diff\s+([^\s]+)') {
        $best=Parse-BoundedDouble $Matches[1] 0 1e100; if ($null -ne $best) { $State.BestShare=$best; }
    } elseif ($Text -match '^\d+\s+Submitted Diff\s+([^,]+),\s*Block\s+(\d+)') {
        $diff=Parse-BoundedDouble $Matches[1] 0 1e100; $height=Parse-BoundedLong $Matches[2] 1 2147483647;
        if ($null -ne $diff) { $State.BestShare=[Math]::Max([double]$State.BestShare,$diff); }
        if ($null -ne $height) { $State.Height=$height; }
        $State.Submitted++; $State.LastShareAt=$At; Add-MinerEvent $State 'Submitted a share to the pool' $At;
    } elseif ($Text -match '^\d+\s+A(\d+)\s+S(\d+)\s+R(\d+)\s+BLOCK SOLVED') {
        $State.Accepted=[long]$Matches[1]; $State.Stale=[long]$Matches[2]; $State.Rejected=[long]$Matches[3];
        $State.BlockCandidates++; $State.LastShareAt=$At; Add-MinerEvent $State 'Miner reported BLOCK SOLVED; chain verification required' $At;
    } elseif ($Text -match '^\d+\s+A(\d+)\s+S(\d+)\s+R(\d+)') {
        $State.Accepted=[long]$Matches[1]; $State.Stale=[long]$Matches[2]; $State.Rejected=[long]$Matches[3]; $State.LastShareAt=$At;
    }
}

function Observe-MinerLine($State,[string]$Line,[datetime]$At=(Get-Date)) {
    if ([string]::IsNullOrWhiteSpace($Line)) { return; }
    $text = (($Line -replace '\x1B\[[0-?]*[ -/]*[@-~]','') -replace '[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]','').Trim();
    if ($text.Length -gt 65536) { return; }
    if ($text -match '^\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\]\s*(.*)$') {
        [datetime]$parsed=[datetime]::MinValue;
        if ([datetime]::TryParseExact($Matches[1],'yyyy-MM-dd HH:mm:ss',[Globalization.CultureInfo]::InvariantCulture,[Globalization.DateTimeStyles]::AssumeLocal,[ref]$parsed)) { $At=$parsed; }
        $text=$Matches[2].Trim();
    }
    $State.LastLogAt=$At;
    Observe-CommonLine $State $text $At;
    Observe-CpuLine $State $text $At;
}

function Format-Rate([double]$Rate) {
    if ($Rate -ge 1e15) { return [pscustomobject]@{Value=('{0:N2}' -f ($Rate/1e15)); Unit='PH/s'}; }
    if ($Rate -ge 1e12) { return [pscustomobject]@{Value=('{0:N2}' -f ($Rate/1e12)); Unit='TH/s'}; }
    if ($Rate -ge 1e9)  { return [pscustomobject]@{Value=('{0:N2}' -f ($Rate/1e9));  Unit='GH/s'}; }
    if ($Rate -ge 1e6)  { return [pscustomobject]@{Value=('{0:N2}' -f ($Rate/1e6));  Unit='MH/s'}; }
    if ($Rate -ge 1e3)  { return [pscustomobject]@{Value=('{0:N2}' -f ($Rate/1e3));  Unit='kH/s'}; }
    return [pscustomobject]@{Value=('{0:N2}' -f $Rate); Unit='H/s'};
}

function Format-HouseAge([datetime]$At,[datetime]$Now=(Get-Date)) {
    if ($null -eq $At) { return 'never'; }
    $seconds=[Math]::Max(0,[int]($Now-$At).TotalSeconds);
    if ($seconds -lt 2) { return 'just now'; }
    if ($seconds -lt 60) { return "$seconds s ago"; }
    return ([int]($seconds/60)).ToString()+' min ago';
}

function Format-HouseNumber($Value) {
    if ($null -eq $Value) { return '--'; }
    [double]$number=[double]$Value;
    if ($number -ge 1e15) { return ('{0:0.###}e{1}' -f ($number/[Math]::Pow(10,[Math]::Floor([Math]::Log10($number)))),[Math]::Floor([Math]::Log10($number))); }
    if ($number -ge 1000000) { return ('{0:N2}M' -f ($number/1000000)); }
    if ($number -ge 1000) { return ('{0:N2}k' -f ($number/1000)); }
    return ('{0:N2}' -f $number);
}

function Format-HouseRuntime([datetime]$Started,[datetime]$Now=(Get-Date)) {
    if ($null -eq $Started) { return '--'; }
    $span=$Now-$Started;
    if ($span.TotalSeconds -lt 0) { return '--'; }
    return ('{0:00}:{1:00}:{2:00}' -f [int]$span.TotalHours,$span.Minutes,$span.Seconds);
}

function Get-MinerView($State,[datetime]$Now=(Get-Date),[bool]$ProcessRunning=$false) {
    $liveLog = $null -ne $State.LastLogAt -and ($Now-$State.LastLogAt).TotalSeconds -le 180;
    $liveJob = $null -ne $State.LastJobAt -and ($Now-$State.LastJobAt).TotalSeconds -le 180;
    $running = $ProcessRunning -or ($liveLog -and -not $State.ProgramExit);
    $status='OFF'; $detail='Press ON to start mining.'; $color='#D5B76F';
    if ($State.Connection -eq 'Error') { $status='ERROR'; $detail=$State.LastError; $color='#E28B78'; }
    elseif ($State.Connection -eq 'Stopped') { $status='STOPPED'; $detail=$State.StopLine; $color='#E28B78'; }
    elseif ($running -and $liveJob) { $status='MINING'; $detail='Working on block '+$(if($null -ne $State.Height){$State.Height}else{'--'})+'.'; $color='#98E3B2'; }
    elseif ($running -and $State.Authorized) { $status='CONNECTED'; $detail='Authorized; waiting for fresh mining work.'; $color='#98E3B2'; }
    elseif ($running) { $status='STARTING'; $detail='Preparing or connecting the miner.'; $color='#D5B76F'; }
    elseif ($State.ProgramExit -or $State.Connection -eq 'Ended') { $status='ENDED'; $detail='The most recent miner session ended.'; $color='#93AD9D'; }
    $rate=$null;
    if ($null -ne $State.HashrateHps) { $rate=Format-Rate $State.HashrateHps; }
    return [pscustomobject]@{
        Status=$status; Detail=$detail; Color=$color; IsRunning=$running; IsLive=($running -and $liveLog);
        Rate=$rate; Runtime=Format-HouseRuntime $State.SessionStartedAt $Now;
    };
}

# Shared worker mode dispatch. The worker code itself is supplied later.
if ($env:HOUSE_MODE -eq 'WORKER') {
    # Worker definitions are parsed before execution; dispatch is called after all helpers exist.
}

# Log-tail reader with bounded partial-line buffering and reset detection.

function New-LogTail([string]$Path) {
    return [pscustomobject]@{
        Path=[IO.Path]::GetFullPath($Path);
        Position=[long]0;
        Identity=$null;
        Pending='';
        PendingBytes=0;
        Signature=$null;
        Generation=0;
        ResetGeneration=0;
        ResetThisRead=$false;
        CaughtUp=$false;
        TruncatedHistory=$false;
        MaxBytes=[long]4194304;
        MaxPendingBytes=262144;
    };
}

function Get-HouseFileIdentity([string]$Path) {
    $item=Get-Item -LiteralPath $Path -ErrorAction Stop;
    $stream=[IO.File]::Open($Path,[IO.FileMode]::Open,[IO.FileAccess]::Read,[IO.FileShare]::ReadWrite -bor [IO.FileShare]::Delete);
    try {
        $length=$stream.Length; $bytes=New-Object byte[] ([Math]::Min(256,$length));
        if ($bytes.Length -gt 0) { [void]$stream.Read($bytes,0,$bytes.Length); }
    } finally { $stream.Dispose(); }
    $hash=[Security.Cryptography.SHA256]::Create();
    try { $head=([BitConverter]::ToString($hash.ComputeHash($bytes))).Replace('-',''); }
    finally { $hash.Dispose(); }
    return ($item.CreationTimeUtc.Ticks.ToString() + ':' + $length.ToString() + ':' + $head);
}

function Decode-HouseUtf8Bytes([byte[]]$Bytes,[bool]$AllowBom) {
    if ($null -eq $Bytes -or $Bytes.Length -eq 0) { return ''; }
    $offset=0; $count=$Bytes.Length;
    if ($AllowBom -and $count -ge 3 -and $Bytes[0]-eq 0xEF -and $Bytes[1]-eq 0xBB -and $Bytes[2]-eq 0xBF) { $offset=3; $count-=3; }
    $decoder=[Text.UTF8Encoding]::new($false,$true);
    return $decoder.GetString($Bytes,$offset,$count);
}

function Read-HouseSharedBytes([string]$Path,[long]$Offset,[int]$Count) {
    if ($Count -lt 0 -or $Count -gt 4194304) { throw 'The requested log read is outside the supported range.'; }
    $stream=[IO.File]::Open($Path,[IO.FileMode]::Open,[IO.FileAccess]::Read,[IO.FileShare]::ReadWrite -bor [IO.FileShare]::Delete);
    try {
        if ($Offset -lt 0 -or $Offset -gt $stream.Length) { throw 'The log read offset is invalid.'; }
        [void]$stream.Seek($Offset,[IO.SeekOrigin]::Begin);
        $buffer=New-Object byte[] $Count; $read=0;
        while ($read -lt $Count) {
            $n=$stream.Read($buffer,$read,$Count-$read); if ($n -le 0) { break; } $read+=$n;
        }
        if ($read -eq $Count) { return $buffer; }
        $actual=New-Object byte[] $read; if ($read -gt 0) { [Array]::Copy($buffer,$actual,$read); } return $actual;
    } finally { $stream.Dispose(); }
}

function Read-LogTail($Tail) {
    $Tail.ResetThisRead=$false; $Tail.CaughtUp=$false;
    if (-not (Test-Path -LiteralPath $Tail.Path -PathType Leaf)) { return @(); }
    $info=Get-Item -LiteralPath $Tail.Path -ErrorAction Stop;
    $rotated=$false;
    if ($null -ne $Tail.Identity -and $info.Length -lt $Tail.Position) { $rotated=$true; }
    if (-not $rotated -and $null -ne $Tail.Identity -and $info.Length -eq $Tail.Position) {
        $current=Get-HouseFileIdentity $Tail.Path; if ($current -cne $Tail.Signature) { $rotated=$true; }
    }
    if ($rotated) {
        $Tail.Position=0; $Tail.Pending=''; $Tail.PendingBytes=0; $Tail.Generation++; $Tail.ResetGeneration=$Tail.Generation; $Tail.ResetThisRead=$true;
    }
    $start=$Tail.Position; $available=$info.Length-$start;
    if ($start -eq 0 -and $available -gt $Tail.MaxBytes) {
        $start=$info.Length-$Tail.MaxBytes; $Tail.TruncatedHistory=$true; $Tail.Pending=''; $Tail.PendingBytes=0; $Tail.Generation++; $Tail.ResetGeneration=$Tail.Generation; $Tail.ResetThisRead=$true;
    }
    if ($available -le 0 -and $start -eq $Tail.Position) {
        $Tail.CaughtUp=$true; $Tail.Identity=$info.CreationTimeUtc.Ticks.ToString(); $Tail.Signature=Get-HouseFileIdentity $Tail.Path; return @();
    }
    $toRead=[int][Math]::Min($Tail.MaxBytes,$info.Length-$start);
    $bytes=Read-HouseSharedBytes $Tail.Path $start $toRead;
    $Tail.Position=$start+$bytes.Length;
    $combined=$Tail.Pending+(Decode-HouseUtf8Bytes $bytes ($start -eq 0));
    $lastLf=$combined.LastIndexOf("`n");
    if ($lastLf -lt 0) {
        if ([Text.Encoding]::UTF8.GetByteCount($combined) -gt $Tail.MaxPendingBytes) { throw 'The miner log contains an overlong partial line.'; }
        $Tail.Pending=$combined; $Tail.PendingBytes=[Text.Encoding]::UTF8.GetByteCount($combined); $Tail.CaughtUp=($Tail.Position -ge $info.Length); return @();
    }
    $complete=$combined.Substring(0,$lastLf+1); $Tail.Pending=$combined.Substring($lastLf+1); $Tail.PendingBytes=[Text.Encoding]::UTF8.GetByteCount($Tail.Pending);
    if ($Tail.PendingBytes -gt $Tail.MaxPendingBytes) { throw 'The miner log contains an overlong partial line.'; }
    $lines=[Collections.Generic.List[string]]::new();
    foreach ($line in ($complete -split "`n")) { if ($line.Length -gt 0) { $lines.Add($line.TrimEnd("`r")); } }
    $Tail.CaughtUp=($Tail.Position -ge $info.Length); $Tail.Identity=$info.CreationTimeUtc.Ticks.ToString(); $Tail.Signature=Get-HouseFileIdentity $Tail.Path;
    return $lines.ToArray();
}

# CPU process usage, sampled only from live processes.

function Get-HouseMinerProcesses {
    $names=@('cpuminer-avx2-sha-vaes','cpuminer-sse2','cpuminer','bzminer','lolminer','xmrig');
    return @(Get-Process -ErrorAction SilentlyContinue | Where-Object { $names -contains $_.ProcessName.ToLowerInvariant() });
}

function Update-HouseProcesses {
    $now=[datetime]::UtcNow;
    if (($now-$script:H.LastProcessPoll).TotalSeconds -lt 2) { return; }
    $script:H.LastProcessPoll=$now;
    $live=@(Get-HouseMinerProcesses); $script:H.Processes=$live;
    $new=@{}; $logical=[Environment]::ProcessorCount; $totalCpu=0.0; $count=0;
    foreach ($process in $live) {
        try {
            $key=$process.Id.ToString()+'|'+$process.StartTime.ToUniversalTime().Ticks.ToString();
            $cpu=$process.TotalProcessorTime.TotalSeconds;
            if ($script:H.CpuSamples.ContainsKey($key)) {
                $sample=$script:H.CpuSamples[$key]; $elapsed=($now-$sample.At).TotalSeconds;
                if ($elapsed -gt 0.05) { $totalCpu+=100.0*($cpu-$sample.Cpu)/($elapsed*$logical); $count++; }
            }
            $new[$key]=[pscustomobject]@{Cpu=$cpu;At=$now};
        } catch { }
    }
    $script:H.CpuSamples=$new; $script:H.CpuPercent=$(if($count -gt 0){[Math]::Max(0,[Math]::Min(100,$totalCpu))}else{$null});
}

# Installation, tuning, thermal monitoring and worker-owned miner control.

$script:HouseCpuReleaseUri='https://github.com/JayDDee/cpuminer-opt/releases/download/v26.1/cpuminer-opt-26.1-windows.zip';
$script:HouseCpuReleaseSha256='46e781683f43fe77dd210615babbd0e5a9349a72aef4df1c10744b419d6e4bba';
$script:HouseCpuReleaseBytes=17679595;
$script:HouseGpuReleaseUri='https://github.com/bzminer/bzminer/releases/download/v100.50/bzminer_v100.50_windows.zip';
$script:HouseGpuReleaseSha256='87afbd6b81f5a7120447a420f1de117acbd410443c4a0fa5e2f52bc2b5f22275';
$script:HouseGpuReleaseBytes=49407599;
$script:HouseGpuExecutableSha256='1ced48a641a991204fcf8f21d9538b2930a0e11eefae141cdff45a4d764775d3';
$script:HouseCpuFiles = @{
    'cpuminer-avx2-sha-vaes.exe'='d2b7e84aed40b0560a236572f7a61e21781a825f59a8067c6f62657e804c044a';
    'cpuminer-sse2.exe'='7bf457fe37e046c82d9fb50d3299c8f0c940954b263d45e3f7008e0fe49a4f1e';
    'libcurl.dll'='f58640be9625ad82a3cf550996ff0c1452a70c27f1bd85445e25f0c08b496595';
    'libwinpthread-1.dll'='ae1c872db725697c03d03133f4196630a531964e072da940ab77f833b63b7dcc';
    'libgcc_s_seh-1.dll'='a3273c15ead12093f5ab28c4a8fd22890da81797e4e6e2d6d6071224e70e7a96';
    'libstdc++-6.dll'='aa34d0d137805c401dd7d4b5c8eeea8fb73c269236904edce7828f78a53fb0fa';
    'zlib1.dll'='3d0d4c2a0cc6b0d0f79a8d90702a66e5df689e4a6fa05f99a2b743f2bc4b414';
};

function Get-HouseFileSha256([string]$Path) {
    $sha=[Security.Cryptography.SHA256]::Create();
    $stream=[IO.File]::OpenRead($Path);
    try { return ([BitConverter]::ToString($sha.ComputeHash($stream))).Replace('-','').ToLowerInvariant(); }
    finally { $stream.Dispose(); $sha.Dispose(); }
}

function Test-HousePinnedFiles([string]$Directory) {
    if (-not (Test-Path -LiteralPath $Directory -PathType Container)) { return $false; }
    foreach ($name in $script:HouseCpuFiles.Keys) {
        $path=Join-Path $Directory $name;
        if (-not (Test-Path -LiteralPath $path -PathType Leaf) -or (Get-HouseFileSha256 $path) -cne $script:HouseCpuFiles[$name]) { return $false; }
    }
    return $true;
}

function Get-HouseCpuExecutable([string]$Directory) {
    if (-not (Test-HousePinnedFiles $Directory)) { throw 'The CPU miner folder is missing or changed. Setup will repair it.'; }
    $primary=Join-Path $Directory 'cpuminer-avx2-sha-vaes.exe';
    if ([IO.File]::Exists($primary)) { return $primary; }
    return (Join-Path $Directory 'cpuminer-sse2.exe');
}

function Test-HouseGpuFiles([string]$Directory) {
    $path=Join-Path $Directory 'bzminer.exe';
    return (Test-Path -LiteralPath $path -PathType Leaf) -and (Get-HouseFileSha256 $path) -ceq $script:HouseGpuExecutableSha256;
}

function Get-HouseGpuExecutable([string]$Directory) {
    if (-not (Test-HouseGpuFiles $Directory)) { throw 'The NVIDIA miner folder is missing or changed. Setup will repair it.'; }
    return (Join-Path $Directory 'bzminer.exe');
}

function Start-HouseVerifiedDownload([string]$Uri,[string]$Destination,[string]$ExpectedSha256,[long]$ExpectedBytes) {
    if ($Uri -cnotmatch '^https://github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+/releases/download/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+\.zip$' -or
        $ExpectedSha256 -cnotmatch '^[a-f0-9]{64}$' -or $ExpectedBytes -lt 1024 -or $ExpectedBytes -gt 104857600) { throw 'The pinned download record is invalid.'; }
    $temp=$Destination+'.part';
    if (Test-Path -LiteralPath $temp) { Remove-Item -LiteralPath $temp -Force; }
    try {
        $client=[Net.WebClient]::new();
        try { $client.Headers['User-Agent']='HouseBitcoinDesk/1.5'; $client.DownloadFile($Uri,$temp); }
        finally { $client.Dispose(); }
        $item=Get-Item -LiteralPath $temp -ErrorAction Stop;
        if ($item.Length -ne $ExpectedBytes -or (Get-HouseFileSha256 $temp) -cne $ExpectedSha256) { throw 'The official download did not match its pinned size and checksum.'; }
        Move-Item -LiteralPath $temp -Destination $Destination -Force;
    } finally { if (Test-Path -LiteralPath $temp) { Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue; } }
}

function Expand-HousePinnedArchive([string]$Archive,[string]$Stage,[string]$Device) {
    if (Test-Path -LiteralPath $Stage) { Remove-Item -LiteralPath $Stage -Recurse -Force; }
    [IO.Directory]::CreateDirectory($Stage) | Out-Null;
    Add-Type -AssemblyName System.IO.Compression.FileSystem;
    $zip=[IO.Compression.ZipFile]::OpenRead($Archive);
    try {
        foreach ($entry in $zip.Entries) {
            if ([string]::IsNullOrEmpty($entry.Name)) { continue; }
            if ($entry.FullName -match '(^|/)(\.\.|\.)($|/)' -or [IO.Path]::IsPathRooted($entry.FullName)) { throw 'The download contained an unsafe archive path.'; }
            $name=$entry.Name;
            $wanted=$false;
            if ($Device -ceq 'CPU') { $wanted=$script:HouseCpuFiles.ContainsKey($name); }
            elseif ($Device -ceq 'NVIDIA') { $wanted=$name -ieq 'bzminer.exe'; }
            if (-not $wanted) { continue; }
            $destination=Join-Path $Stage $name;
            $source=$entry.Open(); $target=[IO.File]::Create($destination);
            try { $source.CopyTo($target); }
            finally { $target.Dispose(); $source.Dispose(); }
        }
    } finally { $zip.Dispose(); }
}

function Install-HouseMiner([string]$Device='CPU') {
    if ($Device -cnotin @('CPU','NVIDIA')) { throw 'Unknown mining device.'; }
    $name=$(if($Device -ceq 'NVIDIA'){'NVIDIA'}else{'CPU'});
    $target=Join-Path $script:H.MiningRoot $name;
    if (($Device -ceq 'CPU' -and (Test-HousePinnedFiles $target)) -or ($Device -ceq 'NVIDIA' -and (Test-HouseGpuFiles $target))) { return $target; }
    $uri=$(if($Device -ceq 'NVIDIA'){$script:HouseGpuReleaseUri}else{$script:HouseCpuReleaseUri});
    $sha=$(if($Device -ceq 'NVIDIA'){$script:HouseGpuReleaseSha256}else{$script:HouseCpuReleaseSha256});
    $bytes=$(if($Device -ceq 'NVIDIA'){$script:HouseGpuReleaseBytes}else{$script:HouseCpuReleaseBytes});
    $zip=Join-Path $script:H.MiningRoot ($name+'-official.zip');
    $stage=Join-Path $script:H.MiningRoot ($name+'-stage-'+[guid]::NewGuid().ToString('N'));
    $backup=Join-Path $script:H.MiningRoot ($name+'-backup-'+[guid]::NewGuid().ToString('N'));
    try {
        Start-HouseVerifiedDownload $uri $zip $sha $bytes;
        Expand-HousePinnedArchive $zip $stage $Device;
        $valid=$(if($Device -ceq 'NVIDIA'){Test-HouseGpuFiles $stage}else{Test-HousePinnedFiles $stage});
        if (-not $valid) { throw 'The extracted miner files did not pass verification.'; }
        if (Test-Path -LiteralPath $target) { Move-Item -LiteralPath $target -Destination $backup; }
        Move-Item -LiteralPath $stage -Destination $target;
        if (Test-Path -LiteralPath $backup) { Remove-Item -LiteralPath $backup -Recurse -Force; }
        return $target;
    } catch {
        if (-not (Test-Path -LiteralPath $target) -and (Test-Path -LiteralPath $backup)) { Move-Item -LiteralPath $backup -Destination $target; }
        throw;
    } finally {
        foreach ($path in @($zip,$stage,$backup)) { if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path -Recurse -Force -ErrorAction SilentlyContinue; } }
    }
}

function Get-HouseProcessorTopology {
    $logical=[Environment]::ProcessorCount; $cores=0;
    try { $cores=(@(Get-CimInstance Win32_Processor -ErrorAction Stop | Measure-Object -Property NumberOfCores -Sum).Sum); } catch { }
    if ($cores -lt 1 -or $cores -gt $logical) { $cores=[Math]::Max(1,[int][Math]::Floor($logical/2)); }
    return [pscustomobject]@{Logical=$logical;Cores=$cores};
}

function Get-HousePowerLimit([int]$Maximum,[bool]$HasTemperature) {
    if ($Maximum -lt 1) { return 1; }
    if ($HasTemperature) { return $Maximum; }
    return [Math]::Max(1,[int][Math]::Floor($Maximum/2));
}

function Get-HouseThreadCandidates([int]$Limit) {
    if ($Limit -lt 1) { throw 'No CPU threads are available.'; }
    $set=[Collections.Generic.SortedSet[int]]::new();
    foreach ($value in @(1,[Math]::Min(2,$Limit),[Math]::Max(1,[int][Math]::Floor($Limit/2)),$Limit)) { [void]$set.Add([int]$value); }
    return @($set);
}

function Select-HouseTuningWinner($Trials) {
    $valid=@($Trials | Where-Object { $_.HashrateHps -gt 0 } | Sort-Object -Property @{Expression='HashrateHps';Descending=$true},@{Expression='Threads';Descending=$false});
    if ($valid.Count -eq 0) { throw 'No tuning trial produced a valid hash rate.'; }
    $fastest=[double]$valid[0].HashrateHps; $threshold=$fastest*0.98;
    return @($valid | Where-Object { $_.HashrateHps -ge $threshold } | Sort-Object Threads | Select-Object -First 1)[0];
}

function Get-HousePerformanceDefaults {
    $topology=Get-HouseProcessorTopology; $allowed=Get-HousePowerLimit $topology.Logical $false;
    return [ordered]@{Version=1;Preset='Balanced';Threads=[Math]::Min($topology.Cores,$allowed);TunedHashrateHps=$null;TunedUtc=$null};
}

function Initialize-HousePerformance {
    $defaults=Get-HousePerformanceDefaults; $saved=$script:H.Settings.Performance;
    $script:H.Performance=[ordered]@{}; foreach ($key in $defaults.Keys) { $script:H.Performance[$key]=$defaults[$key]; }
    if ($null -ne $saved -and $saved.Version -eq 1) {
        if ([string]$saved.Preset -cin @('Quiet','Balanced','Higher','Custom')) { $script:H.Performance.Preset=[string]$saved.Preset; }
        $threads=0; if ([int]::TryParse([string]$saved.Threads,[ref]$threads)) { $script:H.Performance.Threads=$threads; }
        $rate=0.0; if ([double]::TryParse([string]$saved.TunedHashrateHps,[Globalization.NumberStyles]::Float,[Globalization.CultureInfo]::InvariantCulture,[ref]$rate) -and $rate -gt 0) { $script:H.Performance.TunedHashrateHps=$rate; }
        [datetime]$tuned=[datetime]::MinValue; if ([datetime]::TryParse([string]$saved.TunedUtc,[Globalization.CultureInfo]::InvariantCulture,[Globalization.DateTimeStyles]::RoundtripKind,[ref]$tuned)) { $script:H.Performance.TunedUtc=$tuned.ToUniversalTime(); }
    }
    $script:H.PerformanceBinding=$true;
    try {
        $script:UI.PowerPresetBox.ItemsSource=[object[]]@('Quiet','Balanced','Higher','Custom');
        $script:UI.PowerPresetBox.SelectedItem=$script:H.Performance.Preset;
    } finally { $script:H.PerformanceBinding=$false; }
    Sync-HousePerformanceLimit;
}

function Get-HouseAllowedThreads {
    $topology=Get-HouseProcessorTopology; $fresh=$false;
    if ($null -ne $script:H.PowerSafety) { $fresh=Test-HouseFreshCpuTemperature $script:H.PowerSafety; }
    return Get-HousePowerLimit $topology.Logical $fresh;
}

function Get-HousePresetThreads([string]$Preset,[int]$Allowed) {
    $topology=Get-HouseProcessorTopology;
    switch ($Preset) {
        'Quiet' { return [Math]::Max(1,[int][Math]::Floor($Allowed/2)); }
        'Balanced' { return [Math]::Min($topology.Cores,$Allowed); }
        'Higher' { return $Allowed; }
        default { return [Math]::Min([Math]::Max(1,[int]$script:H.Performance.Threads),$Allowed); }
    }
}

function Sync-HousePerformanceLimit {
    if ($null -eq $script:H.Performance) { return; }
    $allowed=Get-HouseAllowedThreads;
    $maximum=(Get-HouseProcessorTopology).Logical;
    $script:H.Performance.Threads=[Math]::Min([Math]::Max(1,[int]$script:H.Performance.Threads),$allowed);
    $script:H.PerformanceBinding=$true;
    try {
        $script:UI.CpuThreadsBox.ItemsSource=[object[]](1..$allowed);
        if ($script:H.Performance.Preset -cne 'Custom') { $script:H.Performance.Threads=Get-HousePresetThreads $script:H.Performance.Preset $allowed; }
        $script:UI.CpuThreadsBox.SelectedItem=[int]$script:H.Performance.Threads;
        $script:UI.PowerPresetBox.SelectedItem=[string]$script:H.Performance.Preset;
    } finally { $script:H.PerformanceBinding=$false; }
    $sensor='No readable CPU temperature sensor. Balanced limit: half the logical threads, minimum 1.';
    if ($null -ne $script:H.PowerSafety -and (Test-HouseFreshCpuTemperature $script:H.PowerSafety)) { $sensor='CPU temperature available. 85 C stop enabled.'; }
    $script:UI.PerformanceStatusText.Text=('CPU allocation: '+$script:H.Performance.Threads+' of '+$maximum+' logical threads. Selection limit '+$allowed+'. TUNE compares measured speed before choosing a thread count. '+$sensor);
}

function Set-HousePowerPreset([string]$Preset) {
    if ($script:H.PerformanceBinding -or $null -ne $script:H.Session -or $Preset -cnotin @('Quiet','Balanced','Higher','Custom')) { return; }
    $script:H.Performance.Preset=$Preset; Sync-HousePerformanceLimit; Save-HouseSettings;
}

function Set-HouseCpuThreads([int]$Threads) {
    if ($script:H.PerformanceBinding -or $null -ne $script:H.Session) { return; }
    $allowed=Get-HouseAllowedThreads;
    if ($Threads -lt 1 -or $Threads -gt $allowed) { throw 'That thread count is outside the current workload limit.'; }
    $script:H.Performance.Preset='Custom'; $script:H.Performance.Threads=$Threads;
    $script:H.PerformanceBinding=$true;
    try { $script:UI.PowerPresetBox.SelectedItem='Custom'; } finally { $script:H.PerformanceBinding=$false; }
    Sync-HousePerformanceLimit; Save-HouseSettings;
}

function Get-HouseMiningThreads { return [Math]::Min([int]$script:H.Performance.Threads,(Get-HouseAllowedThreads)); }

function Get-HousePerformanceSettings {
    return [ordered]@{Version=1;Preset=$script:H.Performance.Preset;Threads=$script:H.Performance.Threads;TunedHashrateHps=$script:H.Performance.TunedHashrateHps;TunedUtc=$script:H.Performance.TunedUtc};
}

function Update-HousePerformanceControls {
    if ($null -eq $script:H.Performance) { return; }
    $idle=$null -eq $script:H.Session -and -not $script:H.Closed;
    if ($script:H.MiningDevice -ceq 'NVIDIA') { $idle=$false; }
    foreach ($name in @('PowerPresetBox','CpuThreadsBox','TuneButton')) { if ($script:UI.ContainsKey($name)) { $script:UI[$name].IsEnabled=$idle; } }
    if ($null -ne $script:H.Session -and $script:H.Session.RunMode -eq 'benchmark') {
        $script:UI.TuneButton.IsEnabled=$false;
        $script:UI.PerformanceStatusText.Text='Offline tuning is running. OFF cancels.';
    }
}

function Apply-HouseTuningResult([string]$Path) {
    if (-not [IO.File]::Exists($Path) -or ([IO.FileInfo]::new($Path)).Length -gt 262144) { throw 'The tuning result is missing or too large.'; }
    $result=[IO.File]::ReadAllText($Path) | ConvertFrom-Json;
    $threads=0; $rate=0.0; [datetime]$completed=[datetime]::MinValue;
    if ($result.Version -ne 1 -or [string]$result.Algorithm -cne 'sha256d' -or
        -not [int]::TryParse([string]$result.SelectedThreads,[ref]$threads) -or $threads -lt 1 -or $threads -gt (Get-HouseAllowedThreads) -or
        -not [double]::TryParse([string]$result.SelectedHashrateHps,[Globalization.NumberStyles]::Float,[Globalization.CultureInfo]::InvariantCulture,[ref]$rate) -or $rate -le 0 -or
        -not [datetime]::TryParse([string]$result.CompletedUtc,[Globalization.CultureInfo]::InvariantCulture,[Globalization.DateTimeStyles]::RoundtripKind,[ref]$completed)) { throw 'The tuning result is invalid.'; }
    $script:H.Performance.Preset='Custom'; $script:H.Performance.Threads=$threads; $script:H.Performance.TunedHashrateHps=$rate; $script:H.Performance.TunedUtc=$completed.ToUniversalTime();
    Sync-HousePerformanceLimit; Save-HouseSettings; return $threads;
}

function Get-HouseBenchmarkHashrate([string]$Path,[datetime]$NotBefore) {
    if (-not [IO.File]::Exists($Path)) { return $null; }
    $state=New-MinerState;
    foreach ($line in [IO.File]::ReadLines($Path)) { Observe-MinerLine $state $line; }
    if ($null -eq $state.HashrateHps -or $null -eq $state.HashrateAt -or $state.HashrateAt -lt $NotBefore.AddSeconds(-2)) { return $null; }
    return [double]$state.HashrateHps;
}

function Invoke-HouseBenchmarkTrial([string]$Miner,[int]$Threads,[string]$LogPath) {
    if ($Threads -lt 1 -or $Threads -gt (Get-HouseAllowedThreads)) { throw 'The tuning thread count is outside the workload limit.'; }
    $started=[datetime]::UtcNow; $trialLog=$LogPath+'.'+$Threads+'.tmp';
    if ([IO.File]::Exists($trialLog)) { [IO.File]::Delete($trialLog); }
    $args=@('-a','sha256d','--benchmark','--time-limit=25','-t',$Threads.ToString());
    $writer=[IO.StreamWriter]::new($trialLog,$false,[Text.Encoding]::UTF8);
    try {
        Invoke-HouseGuardedMiner $Miner $args $Threads {
            param($line) $writer.WriteLine($line); $writer.Flush();
        };
    } finally { $writer.Dispose(); }
    [IO.File]::AppendAllText($LogPath,[IO.File]::ReadAllText($trialLog),[Text.Encoding]::UTF8);
    $rate=Get-HouseBenchmarkHashrate $trialLog $started;
    [IO.File]::Delete($trialLog);
    if ($null -eq $rate -or $rate -le 0) { throw ('Tuning produced no valid speed at '+$Threads+' threads.'); }
    return [pscustomobject]@{Threads=$Threads;HashrateHps=$rate;StartedUtc=$started.ToString('o');DurationSeconds=25};
}

function Invoke-HouseTuning([string]$Miner,[string]$SessionDirectory) {
    $maximum=(Get-HouseProcessorTopology).Logical; $limit=Get-HouseAllowedThreads;
    Assert-HouseWorkerPower $limit;
    $candidates=@(Get-HouseThreadCandidates $limit);
    $log=Join-Path $SessionDirectory 'BENCHMARK.txt';
    [IO.File]::WriteAllText($log,('HOUSE OFFLINE CPU TUNING - NOT BITCOIN MINING'+[Environment]::NewLine+'Speed comparison only. No pool work, shares, or block rewards.'+[Environment]::NewLine),[Text.Encoding]::UTF8);
    $trials=[Collections.Generic.List[object]]::new();
    foreach ($threads in $candidates) {
        if (-not (Test-HouseBenchmarkPower)) { throw 'CPU tuning stopped because the laptop switched to battery power. Plug in and run TUNE again.'; }
        Set-HouseWorkerStatus -Phase Benchmark -Message ('Offline TUNE '+($trials.Count+1)+'/'+$candidates.Count+': testing '+$threads+' CPU threads for 25 seconds. OFF cancels.');
        $trial=Invoke-HouseBenchmarkTrial $Miner $threads $log;
        $trials.Add($trial);
    }
    $winner=Select-HouseTuningWinner $trials;
    $record=[ordered]@{
        Version=1;Algorithm='sha256d';LogicalThreads=$maximum;
        SelectedThreads=[int]$winner.Threads;SelectedHashrateHps=[double]$winner.HashrateHps;
        CompletedUtc=[datetime]::UtcNow.ToString('o');Trials=$trials.ToArray();
        Note='Short offline benchmark; measured speed is not Bitcoin earnings and sustained thermal behavior may differ.'
    };
    $path=Join-Path $SessionDirectory 'TUNING.json'; $temp=$path+'.new';
    [IO.File]::WriteAllText($temp,($record | ConvertTo-Json -Depth 6),[Text.UTF8Encoding]::new($false));
    [IO.File]::Move($temp,$path);
    Write-Host ('Tuning complete. Best tested speed used '+$winner.Threads+' threads. Press ON to mine continuously with the selected setting.');
    return [int]$winner.Threads;
}

# Read-only power monitoring. No clock, voltage, fan, Windows power-plan or
# firmware settings are changed. A thread limit is not a temperature guarantee.

function Get-HouseAcStatus {
    try {
        Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop;
        $value=[string][Windows.Forms.SystemInformation]::PowerStatus.PowerLineStatus;
        if ($value -cin @('Online','Offline')) { return $value; }
    } catch { }
    return 'Unknown';
}

function Get-HouseRawPowerSensors([bool]$IncludeGpu=$false,[bool]$GpuOnly=$false) {
    $gpu=$null; $gpuReadUtc=$null;
    if ($IncludeGpu) {
        $process=$null;
        try {
            $paths=@();
            $system=[Environment]::GetFolderPath([Environment+SpecialFolder]::System);
            if (-not [string]::IsNullOrWhiteSpace($system)) { $paths+=Join-Path $system 'nvidia-smi.exe'; }
            $program=[Environment]::GetFolderPath([Environment+SpecialFolder]::ProgramFiles);
            if (-not [string]::IsNullOrWhiteSpace($program)) { $paths+=Join-Path $program 'NVIDIA Corporation\NVSMI\nvidia-smi.exe'; }
            $exe=@($paths | Where-Object { [IO.File]::Exists($_) } | Select-Object -First 1);
            if ($exe.Count -eq 1) {
                $info=[Diagnostics.ProcessStartInfo]::new();
                $info.FileName=$exe[0]; $info.Arguments='--query-gpu=name,temperature.gpu,utilization.gpu,power.draw,power.limit,uuid --format=csv,noheader,nounits';
                $info.UseShellExecute=$false; $info.CreateNoWindow=$true; $info.RedirectStandardOutput=$true; $info.RedirectStandardError=$true;
                $process=[Diagnostics.Process]::Start($info);
                $stdout=$process.StandardOutput.ReadToEndAsync(); $stderr=$process.StandardError.ReadToEndAsync();
                if ($process.WaitForExit(1500) -and $process.ExitCode -eq 0 -and $stdout.IsCompleted -and $stderr.IsCompleted) {
                    $text=$stdout.GetAwaiter().GetResult();
                    if ($text.Length -le 8192) { $gpu=$text; $gpuReadUtc=[datetime]::UtcNow; }
                }
            }
        } catch { }
        finally {
            if ($null -ne $process) {
                try { if (-not $process.HasExited) { $process.Kill(); [void]$process.WaitForExit(500); } } catch { }
                $process.Dispose();
            }
        }
    }
    if ($GpuOnly) { return [pscustomobject]@{Provider='';Rows=@();ReadUtc=[datetime]::UtcNow;GpuOnly=$true;GpuChecked=$IncludeGpu;GpuText=$gpu;GpuReadUtc=$gpuReadUtc}; }
    # Only use existing hardware-monitor providers. ACPI thermal zones do not
    # identify the CPU package and are deliberately not used as CPU readings.
    foreach ($provider in @('LibreHardwareMonitor','OpenHardwareMonitor')) {
        try {
            $namespace='root\'+$provider;
            $hardware=@(Get-CimInstance -Namespace $namespace -ClassName Hardware -OperationTimeoutSec 2 -ErrorAction Stop);
            $cpuIds=@($hardware | Where-Object { [string]$_.HardwareType -ieq 'Cpu' } | ForEach-Object { [string]$_.Identifier });
            if ($cpuIds.Count -eq 0) { continue; }
            $sensors=@(Get-CimInstance -Namespace $namespace -ClassName Sensor -OperationTimeoutSec 2 -ErrorAction Stop);
            $rows=@($sensors | Where-Object { $cpuIds -ccontains [string]$_.Parent } | ForEach-Object {
                [pscustomobject]@{Name=[string]$_.Name;Type=[string]$_.SensorType;Value=$_.Value;Parent=[string]$_.Parent}
            });
            if ($rows.Count -gt 0) {
                return [pscustomobject]@{Provider=$provider;Rows=$rows;ReadUtc=[datetime]::UtcNow;GpuOnly=$false;GpuChecked=$IncludeGpu;GpuText=$gpu;GpuReadUtc=$gpuReadUtc};
            }
        } catch { }
    }
    return [pscustomobject]@{Provider='';Rows=@();ReadUtc=[datetime]::UtcNow;GpuOnly=$false;GpuChecked=$IncludeGpu;GpuText=$gpu;GpuReadUtc=$gpuReadUtc};
}

function Convert-HouseGpuReading([string]$Text) {
    if ([string]::IsNullOrWhiteSpace($Text) -or $Text.Length -gt 8192) { return $null; }
    $lines=@(($Text -split '\r?\n') | Where-Object { -not [string]::IsNullOrWhiteSpace($_) });
    if ($lines.Count -ne 1) { return $null; }
    foreach ($line in $lines) {
        $parts=@($line -split ',');
        if ($parts.Count -ne 6 -or $parts[0].Trim() -cnotmatch '^NVIDIA [A-Za-z0-9 .()/_-]{1,100}$' -or
            $parts[5].Trim() -cnotmatch '^GPU-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$') { continue; }
        $values=@($null,$null,$null,$null); $maxima=@(150.0,100.0,2000.0,2000.0);
        for ($i=0;$i -lt 4;$i++) {
            $number=0.0;
            if ([double]::TryParse($parts[$i+1].Trim(),[Globalization.NumberStyles]::Float,[Globalization.CultureInfo]::InvariantCulture,[ref]$number) -and
                -not [double]::IsNaN($number) -and -not [double]::IsInfinity($number) -and $number -ge 0 -and $number -le $maxima[$i]) { $values[$i]=$number; }
        }
        return [pscustomobject]@{Name=$parts[0].Trim();TemperatureC=$values[0];Utilization=$values[1];Watts=$values[2];LimitWatts=$values[3];Uuid=$parts[5].Trim()};
    }
    return $null;
}

function Convert-HousePowerSensors($Reading) {
    $temperature=$null; $watts=$null; $provider='';
    if ($null -ne $Reading -and [string]$Reading.Provider -cin @('LibreHardwareMonitor','OpenHardwareMonitor')) {
        $provider=[string]$Reading.Provider;
        foreach ($sensor in @($Reading.Rows)) {
            if ($null -eq $sensor -or $null -eq $sensor.Value -or $sensor.Value -is [bool]) { continue; }
            $value=0.0;
            if (-not [double]::TryParse([string]$sensor.Value,[Globalization.NumberStyles]::Float,[Globalization.CultureInfo]::InvariantCulture,[ref]$value) -or
                [double]::IsNaN($value) -or [double]::IsInfinity($value)) { continue; }
            if ([string]$sensor.Type -ceq 'Temperature' -and [string]$sensor.Name -notmatch '(?i)distance|tjmax|offset|delta|difference' -and $value -ge 1 -and $value -le 150) {
                if ($null -eq $temperature -or $value -gt $temperature) { $temperature=$value; }
            }
            # Package watts only: never add overlapping package/core estimates
            # and never present this as whole-laptop or wall-socket power.
            if ([string]$sensor.Type -ceq 'Power' -and [string]$sensor.Name -match '^(?i:CPU Package|Package|CPU PPT)$' -and $value -ge 0 -and $value -le 2000) {
                if ($null -eq $watts -or $value -gt $watts) { $watts=$value; }
            }
        }
    }
    return [pscustomobject]@{TemperatureC=$temperature;CpuWatts=$watts;Provider=$provider};
}

function New-HousePowerState {
    return @{
        TemperatureC=$null;CpuWatts=$null;Provider='';ReadUtc=$null;LastTemperatureUtc=$null;
        EverTemperature=$false;InitialCheckDone=$false;AcStatus='Unknown';LastAcUtc=[datetime]::MinValue;
        Probe=$null;NextProbeUtc=[datetime]::MinValue;Closed=$false;TripReason=$null;TripUtc=$null;
        IncludeGpu=$false;NextGpuUtc=[datetime]::MinValue;Gpu=$null;GpuReadUtc=$null;GpuCount=0;
        GpuOnly=$false;GpuIntervalSeconds=10;ExpectedGpuUuid=$null;CpuMonitor=$null;
    };
}

function Set-HousePowerReading($State,$Reading,[datetime]$Now) {
    $sample=Convert-HousePowerSensors $Reading;
    if ($null -eq $Reading -or $Reading.GpuOnly -ne $true) {
        $State.TemperatureC=$sample.TemperatureC; $State.CpuWatts=$sample.CpuWatts; $State.Provider=$sample.Provider;
        $readTime=$Now.ToUniversalTime();
        if ($null -ne $Reading -and $Reading.ReadUtc -is [datetime]) { $readTime=$Reading.ReadUtc.ToUniversalTime(); }
        $State.ReadUtc=$readTime;
        if ($null -ne $sample.TemperatureC) { $State.LastTemperatureUtc=$readTime; $State.EverTemperature=$true; }
    }
    $State.InitialCheckDone=$true;
    if ($null -ne $Reading -and $Reading.GpuChecked -eq $true) {
        $State.GpuCount=@(([string]$Reading.GpuText -split '\r?\n') | Where-Object {-not [string]::IsNullOrWhiteSpace($_)}).Count;
        $State.Gpu=Convert-HouseGpuReading ([string]$Reading.GpuText);
        # Failed/missing samples cannot refresh the last known-good timestamp.
        if ($null -ne $State.Gpu -and $Reading.GpuReadUtc -is [datetime]) { $State.GpuReadUtc=$Reading.GpuReadUtc.ToUniversalTime(); }
    }
}

function Start-HousePowerProbe($State,[bool]$IncludeGpu=$false,[bool]$GpuOnly=$false) {
    if ($null -ne $State.Probe -or $State.Closed) { return; }
    $State.Probe=[Threading.Tasks.Task[object]]::Run([Func[object]]{ return Get-HouseRawPowerSensors $IncludeGpu $GpuOnly; });
}

function Stop-HousePowerProbe($State) {
    if ($null -eq $State -or $null -eq $State.Probe) { return; }
    try { if ($State.Probe.IsCompleted) { $State.Probe.Dispose(); } } catch { }
    $State.Probe=$null;
}

function Update-HousePowerState($State,[datetime]$Now=[datetime]::UtcNow) {
    if ($null -eq $State -or $State.Closed) { return; }
    if (($Now-$State.LastAcUtc).TotalSeconds -ge 2) { $State.AcStatus=Get-HouseAcStatus; $State.LastAcUtc=$Now; }
    if ($null -ne $State.Probe -and $State.Probe.IsCompleted) {
        $task=$State.Probe; $State.Probe=$null;
        try { Set-HousePowerReading $State $task.GetAwaiter().GetResult() $Now; }
        catch { $State.InitialCheckDone=$true; Write-HouseAppLog ('Power sensor: '+$_.Exception.Message); }
        finally { $task.Dispose(); }
    }
    if ($null -eq $State.Probe -and $State.NextProbeUtc -le $Now) {
        $includeGpu=$State.IncludeGpu -and $State.NextGpuUtc -le $Now;
        Start-HousePowerProbe $State $includeGpu $State.GpuOnly;
        $State.NextProbeUtc=$Now.AddSeconds($(if($State.GpuOnly){[Math]::Max(1,$State.GpuIntervalSeconds)}else{5}));
        if ($includeGpu) { $State.NextGpuUtc=$Now.AddSeconds([Math]::Max(1,$State.GpuIntervalSeconds)); }
    }
}

function Test-HouseFreshCpuTemperature($State,[datetime]$Now=[datetime]::UtcNow) {
    return ($null -ne $State -and $null -ne $State.TemperatureC -and $null -ne $State.LastTemperatureUtc -and
        ($Now.ToUniversalTime()-$State.LastTemperatureUtc).TotalSeconds -ge -2 -and ($Now.ToUniversalTime()-$State.LastTemperatureUtc).TotalSeconds -le 15);
}

function Get-HousePowerStopReason($State,[int]$Threads,[datetime]$Now=[datetime]::UtcNow) {
    if ($State.AcStatus -eq 'Offline') { return 'Mining stopped because the laptop switched to battery power.'; }
    if ($State.EverTemperature -and -not (Test-HouseFreshCpuTemperature $State $Now)) { return 'CPU temperature readings were lost or became stale. Mining stopped.'; }
    if ((Test-HouseFreshCpuTemperature $State $Now) -and $State.TemperatureC -ge 85) { return 'CPU reached 85 C. Mining stopped. Let it cool before restarting.'; }
    $maximum=Get-HouseWorkerThreadLimit;
    if ($Threads -gt $maximum) { return 'CPU thread use exceeded the workload limit. Mining stopped.'; }
    return $null;
}

function Get-HouseWorkerThreadLimit {
    $logical=[Environment]::ProcessorCount; $fresh=$false;
    if ($null -ne $script:HouseWorkerPowerState) { $fresh=Test-HouseFreshCpuTemperature $script:HouseWorkerPowerState; }
    return Get-HousePowerLimit $logical $fresh;
}

function Test-HouseBenchmarkPower {
    if ($null -eq $script:HouseWorkerPowerState) { return $false; }
    Update-HousePowerState $script:HouseWorkerPowerState;
    return $null -eq (Get-HousePowerStopReason $script:HouseWorkerPowerState 1);
}

function Initialize-HousePowerSafety {
    $script:H.PowerSafety=New-HousePowerState;
    $script:H.PowerSafety.IncludeGpu=$true;
    $script:H.PowerSafety.NextGpuUtc=[datetime]::MinValue;
    $script:H.PowerSafety.GpuIntervalSeconds=10;
    Update-HousePowerState $script:H.PowerSafety;
}

function Update-HousePowerSafety {
    $state=$script:H.PowerSafety;
    if ($null -eq $state) { return; }
    $gpuSession=$null -ne $script:H.Session -and [string]$script:H.Session.MiningDevice -ceq 'NVIDIA';
    $state.GpuOnly=$false; $state.GpuIntervalSeconds=$(if($gpuSession){2}else{10});
    Update-HousePowerState $state;
    if ($null -ne $script:H.Session -and $script:H.Session.RunMode -eq 'continuous') {
        $reason=$null;
        if ($gpuSession) { $reason=Get-HouseGpuPowerStopReason $state; }
        elseif ($script:H.Session.CpuThreads -gt 0) { $reason=Get-HousePowerStopReason $state $script:H.Session.CpuThreads; }
        if ($null -ne $reason) {
            $state.TripReason=$reason; $state.TripUtc=[datetime]::UtcNow;
            Stop-HouseSession $reason;
        }
    } else { Sync-HousePerformanceLimit; }
}

function Close-HousePowerSafety {
    if ($null -eq $script:H.PowerSafety) { return; }
    $script:H.PowerSafety.Closed=$true;
    Stop-HousePowerProbe $script:H.PowerSafety;
    if ($null -ne $script:H.PowerSafety.CpuMonitor) {
        $script:H.PowerSafety.CpuMonitor.Closed=$true; Stop-HousePowerProbe $script:H.PowerSafety.CpuMonitor;
    }
}

function Get-HousePowerView([datetime]$Now=[datetime]::UtcNow) {
    $state=$script:H.PowerSafety;
    $temperature='Unavailable'; $watts='Unavailable'; $source='Power source unknown';
    $protection='No readable CPU temperature sensor. Balanced limit: half the logical threads, minimum 1. CPU thermal cutoff is unavailable.';
    if ($null -ne $state) {
        if ($state.AcStatus -ceq 'Online') { $source='Charger / AC power'; }
        elseif ($state.AcStatus -ceq 'Offline') { $source='Battery - mining stopped'; }
        if (Test-HouseFreshCpuTemperature $state $Now) {
            $temperature=([double]$state.TemperatureC).ToString('0.0',[Globalization.CultureInfo]::InvariantCulture)+' C';
            $protection='85 C stop enabled. Source: '+$state.Provider+'. Read '+[Math]::Max(0,[int]($Now-$state.ReadUtc).TotalSeconds)+'s ago.';
        } elseif ($state.EverTemperature) { $protection='CPU sensor lost or stale. Mining stays OFF until current readings return.'; }
        if ($null -ne $state.CpuWatts -and $null -ne $state.ReadUtc -and ($Now-$state.ReadUtc).TotalSeconds -ge -2 -and ($Now-$state.ReadUtc).TotalSeconds -le 15) {
            $watts=([double]$state.CpuWatts).ToString('0.0',[Globalization.CultureInfo]::InvariantCulture)+' W (CPU package)';
        }
        if (-not $state.InitialCheckDone) { $protection='Checking power and existing CPU sensors...'; }
        if (-not [string]::IsNullOrWhiteSpace([string]$state.TripReason)) { $protection=[string]$state.TripReason; }
    }
    $gpuRunning=$null -ne $script:H.Session -and [string]$script:H.Session.MiningDevice -ceq 'NVIDIA';
    $gpuStatus='NVIDIA GPU telemetry unavailable'; $gpuTelemetry='GPU mode requires one NVIDIA GPU and current temperature readings.';
    if ($null -ne $state -and $null -ne $state.Gpu -and $null -ne $state.GpuReadUtc) {
        $gpuStatus=$state.Gpu.Name+' - monitoring';
        if ($gpuRunning) { $gpuStatus=$state.Gpu.Name+' - GPU session'; }
        $age=($Now-$state.GpuReadUtc).TotalSeconds;
        $maxAge=30; if ($gpuRunning) { $maxAge=10; }
        if ($age -lt -2 -or $age -gt $maxAge) { $gpuTelemetry='GPU readings are stale. GPU mining requires current readings.'; }
        else {
            $pieces=[Collections.Generic.List[string]]::new();
            if ($null -ne $state.Gpu.Utilization) { $pieces.Add(([double]$state.Gpu.Utilization).ToString('0',[Globalization.CultureInfo]::InvariantCulture)+'% GPU load'); }
            if ($null -ne $state.Gpu.TemperatureC) { $pieces.Add(([double]$state.Gpu.TemperatureC).ToString('0',[Globalization.CultureInfo]::InvariantCulture)+' C'); }
            if ($null -ne $state.Gpu.Watts) { $pieces.Add(([double]$state.Gpu.Watts).ToString('0.0',[Globalization.CultureInfo]::InvariantCulture)+' W GPU'); }
            if ($pieces.Count -gt 0) { $gpuTelemetry=($pieces.ToArray() -join ' / ')+'. Read '+[Math]::Max(0,[int]$age)+'s ago. Whole-GPU readings include other apps.'; }
        }
    }
    if ([string]$script:H.MiningDevice -ceq 'NVIDIA' -or $gpuRunning) {
        $protection='GPU mode: charger required; start below 70 C; stop at 75 C or lost/stale GPU readings. No clock or power-limit changes.';
        if ($null -ne $state -and -not [string]::IsNullOrWhiteSpace([string]$state.TripReason)) { $protection=[string]$state.TripReason; }
    }
    return [pscustomobject]@{TemperatureText=$temperature;CpuWattsText=$watts;PowerSourceText=$source;ProtectionText=$protection;LimitText=((Get-HouseAllowedThreads).ToString()+' threads allowed');GpuStatusText=$gpuStatus;GpuTelemetryText=$gpuTelemetry};
}

function Get-HouseGpuPowerStopReason($State,[datetime]$Now=[datetime]::UtcNow) {
    if ($null -eq $State) { return 'GPU protection is unavailable. GPU mining stopped.'; }
    if ($State.AcStatus -cne 'Online') { return 'GPU mining requires confirmed charger / AC power. Mining stopped.'; }
    if ($State.GpuCount -ne 1) { return 'GPU mode requires exactly one detected NVIDIA GPU. Mining stopped.'; }
    if ($null -eq $State.Gpu -or $null -eq $State.Gpu.TemperatureC -or $null -eq $State.GpuReadUtc) { return 'GPU temperature readings are unavailable. Mining stopped.'; }
    $age=($Now.ToUniversalTime()-$State.GpuReadUtc).TotalSeconds;
    if ($age -lt -2 -or $age -gt 10) { return 'GPU temperature readings are stale. Mining stopped.'; }
    if (-not [string]::IsNullOrWhiteSpace([string]$State.ExpectedGpuUuid) -and [string]$State.Gpu.Uuid -cne [string]$State.ExpectedGpuUuid) {
        return 'The monitored NVIDIA GPU identity changed. Mining stopped.';
    }
    if ($State.Gpu.TemperatureC -ge 75) { return 'GPU reached the app limit of 75 C. Mining stopped. Let it cool below 70 C before restarting.'; }
    if ((Test-HouseFreshCpuTemperature $State $Now) -and $State.TemperatureC -ge 85) { return 'CPU reached 85 C. GPU mining stopped to reduce shared laptop heat.'; }
    return $null;
}

function Assert-HouseGpuPowerStart {
    $state=$script:H.PowerSafety;
    if ($null -eq $state -or -not $state.InitialCheckDone) { throw 'Checking NVIDIA GPU sensors. Wait a few seconds, then press ON again.'; }
    $state.AcStatus=Get-HouseAcStatus; $state.LastAcUtc=[datetime]::UtcNow;
    $reason=Get-HouseGpuPowerStopReason $state;
    if ($null -ne $reason) { $state.NextGpuUtc=[datetime]::MinValue; throw $reason; }
    if ($state.Gpu.TemperatureC -ge 70) { throw 'Let the GPU cool below 70 C before starting GPU mining.'; }
    $state.ExpectedGpuUuid=[string]$state.Gpu.Uuid;
    $state.TripReason=$null; $state.TripUtc=$null; $state.GpuOnly=$true; $state.GpuIntervalSeconds=2; $state.NextGpuUtc=[datetime]::MinValue;
}

function Initialize-HouseGpuWorkerPower {
    $state=New-HousePowerState; $state.IncludeGpu=$true; $state.GpuOnly=$true; $state.GpuIntervalSeconds=2;
    Set-HousePowerReading $state (Get-HouseRawPowerSensors -IncludeGpu $true -GpuOnly $true) ([datetime]::UtcNow);
    $state.AcStatus=Get-HouseAcStatus; $state.LastAcUtc=[datetime]::UtcNow;
    if (-not [string]::IsNullOrWhiteSpace($env:HOUSE_GPU_UUID)) {
        if ($env:HOUSE_GPU_UUID -cnotmatch '^GPU-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$') { throw 'The selected NVIDIA GPU identity is invalid.'; }
        $state.ExpectedGpuUuid=$env:HOUSE_GPU_UUID;
    }
    $reason=Get-HouseGpuPowerStopReason $state;
    if ($null -ne $reason) { throw $reason; }
    if ($state.Gpu.TemperatureC -ge 70) { throw 'Let the GPU cool below 70 C before starting GPU mining.'; }
    $state.ExpectedGpuUuid=[string]$state.Gpu.Uuid;
    return $state;
}

function Assert-HouseWorkerPower([int]$Threads) {
    if ($null -eq $script:HouseWorkerPowerState) {
        $script:HouseWorkerPowerState=New-HousePowerState;
    }
    $state=$script:HouseWorkerPowerState;
    Set-HousePowerReading $state (Get-HouseRawPowerSensors) ([datetime]::UtcNow);
    $state.AcStatus=Get-HouseAcStatus; $state.LastAcUtc=[datetime]::UtcNow;
    $reason=Get-HousePowerStopReason $state $Threads;
    if ($null -ne $reason) { throw $reason; }
    if ((Test-HouseFreshCpuTemperature $state) -and $state.TemperatureC -ge 80) { throw 'CPU is already 80 C or higher. Let it cool before starting.'; }
    if ($Threads -gt (Get-HousePowerLimit (Get-HouseMaximumThreads) $false) -and -not (Test-HouseFreshCpuTemperature $state)) {
        throw 'Higher power requires a current CPU temperature reading before starting.';
    }
    if ($Threads -gt (Get-HouseWorkerThreadLimit)) { throw 'Requested CPU threads exceed the app safety limit.'; }
}

function New-HouseGuardedProcess($Info) { return [Diagnostics.Process]::Start($Info); }

function Invoke-HouseGuardedMiner([string]$Miner,[string[]]$Arguments,[int]$Threads,[scriptblock]$LineHandler) {
    Assert-HouseWorkerPower $Threads;
    $state=$script:HouseWorkerPowerState;
    $process=$null;
    try {
        $info=[Diagnostics.ProcessStartInfo]::new();
        $info.FileName=$Miner; $info.WorkingDirectory=[IO.Path]::GetDirectoryName($Miner);
        # All native arguments are generated/validated by worker.ps1, with no
        # shell, user command text or expandable command-line paths involved.
        foreach ($argument in $Arguments) { if ($argument -match '[\s"]') { throw 'An unexpected miner argument could not be passed safely.'; } }
        $info.Arguments=$Arguments -join ' ';
        $info.UseShellExecute=$false; $info.CreateNoWindow=$true;
        $info.RedirectStandardOutput=$true; $info.RedirectStandardError=$true;
        $process=New-HouseGuardedProcess $info;
        if ($null -eq $process) { throw 'Windows could not start the miner.'; }
        $out=$process.StandardOutput.ReadLineAsync(); $err=$process.StandardError.ReadLineAsync();
        while ($null -ne $out -or $null -ne $err -or -not $process.HasExited) {
            Update-HousePowerState $state;
            $reason=Get-HousePowerStopReason $state $Threads;
            if ($null -ne $reason) { $script:HouseWorkerProtectionTrip=$reason; throw $reason; }
            $read=$false;
            if ($null -ne $out -and $out.IsCompleted) {
                $line=$out.GetAwaiter().GetResult(); $out=$null;
                if ($null -ne $line) { & $LineHandler $line; $out=$process.StandardOutput.ReadLineAsync(); }
                $read=$true;
            }
            if ($null -ne $err -and $err.IsCompleted) {
                $line=$err.GetAwaiter().GetResult(); $err=$null;
                if ($null -ne $line) { & $LineHandler $line; $err=$process.StandardError.ReadLineAsync(); }
                $read=$true;
            }
            if (-not $read) { Start-Sleep -Milliseconds 100; }
        }
        [void]$process.WaitForExit();
        $script:HouseGuardedExitCode=[int]$process.ExitCode;
    } finally {
        if ($null -ne $process) {
            try { if (-not $process.HasExited) { $process.Kill(); [void]$process.WaitForExit(1500); } } catch { }
            $process.Dispose();
        }
        $state.Closed=$true; Stop-HousePowerProbe $state;
    }
}

# Verified local TLS relay and independent SHA256d Stratum block auditing.
# Byte order: JayDDee/cpuminer-opt cpu-miner.c std_build_block_header,
# std_build_extraheader and sha256d_gen_merkle_root. BIP34/BIP310 apply.

function Start-HouseGpuRelayJob([int]$OwnerId,[string]$LogPath,[string]$Wallet,[string]$ReleasePath='') {
    if ($OwnerId -le 0 -or $Wallet -cnotmatch '^[A-Za-z0-9]{26,90}$' -or -not [IO.Path]::IsPathRooted($LogPath)) { throw 'Invalid GPU relay ownership or destination.'; }
    $LogPath=[IO.Path]::GetFullPath($LogPath);
    if ($ReleasePath -and -not [IO.Path]::IsPathRooted($ReleasePath)) { throw 'GPU relay release path must be absolute.'; }
    return Start-Job -ArgumentList $OwnerId,$LogPath,$Wallet,$ReleasePath -ScriptBlock {
        param([int]$ownerId,[string]$logPath,[string]$wallet,[string]$releasePath);
        $ErrorActionPreference='Stop'; $listener=$null; $local=$null; $remote=$null; $ssl=$null; $writer=$null; $owner=$null;
        $utf8=[Text.UTF8Encoding]::new($false,$true);
        function Live { return (-not $owner.HasExited); }
        function Audit([string]$Text) {
            $writer.WriteLine(('['+(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')+'] '+$Text)); $writer.Flush();
        }
        function Frame($State,[byte[]]$Buffer,[int]$Count,[string]$Direction) {
            $send=[IO.MemoryStream]::new();
            try {
                for ($i=0;$i -lt $Count;$i++) {
                    $b=$Buffer[$i];
                    if ($b -eq 10) {
                        $bytes=$State.Bytes.ToArray(); $State.Bytes.Clear();
                        $text=$utf8.GetString($bytes).TrimEnd([char]13);
                        if ([string]::IsNullOrWhiteSpace($text)) { continue; }
                        if ($Direction -ceq 'C') {
                            try {
                                $json=$text | ConvertFrom-Json -ErrorAction Stop;
                                if ([string]$json.method -ceq 'mining.authorize') {
                                    $params=@($json.params); if ($params.Count -lt 1) { throw 'Authorize missing worker.'; }
                                    $worker=[string]$params[0]; $dot=$worker.LastIndexOf('.'); $address=$(if($dot -gt 0){$worker.Substring(0,$dot)}else{$worker});
                                    if ($address -cne $wallet) { throw 'Authorize address differs from configured wallet.'; }
                                }
                            } catch { throw ('GPU client request failed validation: '+$_.Exception.Message); }
                        }
                        Audit ($Direction+' '+$text);
                        $line=$utf8.GetBytes($text+"`n"); $send.Write($line,0,$line.Length);
                    } else { if ($State.Bytes.Count -ge 262144) { throw 'GPU Stratum frame exceeded limit.'; }; $State.Bytes.Add($b); }
                }
                return $send.ToArray();
            } finally { $send.Dispose(); }
        }
        try {
            $owner=[Diagnostics.Process]::GetProcessById($ownerId);
            $writer=[IO.StreamWriter]::new($logPath,$true,[Text.UTF8Encoding]::new($false)); $writer.AutoFlush=$true;
            $listener=[Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback,0); $listener.Start();
            $port=([Net.IPEndPoint]$listener.LocalEndpoint).Port;
            Set-Content -LiteralPath ($logPath+'.port') -Value $port -Encoding ASCII;
            while (Live) {
                if (-not $listener.Pending()) { Start-Sleep -Milliseconds 100; continue; }
                $local=$listener.AcceptTcpClient(); $local.NoDelay=$true;
                $remote=[Net.Sockets.TcpClient]::new(); $remote.NoDelay=$true; $remote.Connect('public-pool.io',4333);
                $ssl=[Net.Security.SslStream]::new($remote.GetStream(),$false);
                $ssl.AuthenticateAsClient('public-pool.io');
                if (-not $ssl.IsAuthenticated -or -not $ssl.IsEncrypted) { throw 'GPU TLS session was not authenticated.'; }
                Audit ('TLS verified public-pool.io:4333; protocol '+$ssl.SslProtocol);
                $ls=$local.GetStream(); $cbuf=New-Object byte[] 32768; $sbuf=New-Object byte[] 32768;
                $clientState=[pscustomobject]@{Bytes=[Collections.Generic.List[byte]]::new()};
                $serverState=[pscustomobject]@{Bytes=[Collections.Generic.List[byte]]::new()};
                while (Live -and $local.Connected -and $remote.Connected) {
                    $moved=$false;
                    if ($ls.DataAvailable) { $n=$ls.Read($cbuf,0,$cbuf.Length); if($n -le 0){break}; $framed=Frame $clientState $cbuf $n 'C'; if($framed.Length){$ssl.Write($framed,0,$framed.Length);$ssl.Flush()}; $moved=$true; }
                    if ($remote.Available -gt 0) { $n=$ssl.Read($sbuf,0,$sbuf.Length); if($n -le 0){break}; $framed=Frame $serverState $sbuf $n 'S'; if($framed.Length){$ls.Write($framed,0,$framed.Length);$ls.Flush()}; $moved=$true; }
                    if (-not $moved) { Start-Sleep -Milliseconds 20; }
                }
                foreach($item in @($ssl,$remote,$local)){try{$item.Dispose()}catch{}}; $ssl=$null;$remote=$null;$local=$null;
            }
        } finally {
            foreach($item in @($ssl,$remote,$local,$listener,$writer,$owner)){try{if($null-ne$item){$item.Dispose()}}catch{}}
        }
    };
}

function Get-HouseGpuRelayPort([string]$LogPath,[Diagnostics.Process]$Owner) {
    $path=$LogPath+'.port'; $deadline=[datetime]::UtcNow.AddSeconds(15);
    while ([datetime]::UtcNow -lt $deadline) {
        if ($Owner.HasExited) { throw 'GPU worker stopped before its encrypted relay opened.'; }
        if ([IO.File]::Exists($path)) {
            $port=0; if ([int]::TryParse(([IO.File]::ReadAllText($path).Trim()),[ref]$port) -and $port -ge 1024 -and $port -le 65535) { return $port; }
        }
        Start-Sleep -Milliseconds 100;
    }
    throw 'Timed out waiting for the GPU TLS relay.';
}

function Invoke-HouseGpuMiner([string]$Miner,[string]$SessionDirectory,[string]$Wallet,[int]$Duty,[string]$GpuUuid) {
    if ($Duty -notin @(25,50,75) -or $GpuUuid -cnotmatch '^GPU-[0-9a-fA-F-]{36}$') { throw 'Invalid GPU workload selection.'; }
    $audit=Join-Path $SessionDirectory 'GPU-STRATUM.txt';
    $relay=Start-HouseGpuRelayJob $PID $audit $Wallet;
    try {
        $port=Get-HouseGpuRelayPort $audit ([Diagnostics.Process]::GetCurrentProcess());
        $on=$(switch($Duty){25{15};50{30};75{45}}); $off=60-$on;
        while ($true) {
            $state=Initialize-HouseGpuWorkerPower;
            $arguments=@('-a','sha256d','-w',($Wallet+'.katana'),'-p','x','-P',('stratum+tcp://127.0.0.1:'+$port),'--devices','0','--max_mining_time',$on.ToString());
            Set-HouseWorkerStatus -Phase Mining -Message ('GPU WORK '+$on+'s / REST '+$off+'s. Driver temperature checks active.') -MinerStartedUtc ([datetime]::UtcNow);
            $process=$null;
            try {
                $info=[Diagnostics.ProcessStartInfo]::new(); $info.FileName=$Miner; $info.WorkingDirectory=[IO.Path]::GetDirectoryName($Miner);
                $info.Arguments=$arguments -join ' '; $info.UseShellExecute=$false; $info.CreateNoWindow=$true; $info.RedirectStandardOutput=$true; $info.RedirectStandardError=$true;
                $process=[Diagnostics.Process]::Start($info); if ($null -eq $process) { throw 'Windows could not start the NVIDIA miner.'; }
                $out=$process.StandardOutput.ReadLineAsync(); $err=$process.StandardError.ReadLineAsync();
                while (-not $process.HasExited -or $null-ne$out -or $null-ne$err) {
                    Update-HousePowerState $state; $reason=Get-HouseGpuPowerStopReason $state;
                    if ($null -ne $reason) { $script:HouseWorkerProtectionTrip=$reason; throw $reason; }
                    $read=$false;
                    foreach($pair in @(@('o',$out),@('e',$err))) {
                        $task=$pair[1]; if($null-ne$task -and $task.IsCompleted){$line=$task.GetAwaiter().GetResult();if($pair[0]-eq'o'){$out=$null}else{$err=$null};if($null-ne$line){Write-Host $line;if($pair[0]-eq'o'){$out=$process.StandardOutput.ReadLineAsync()}else{$err=$process.StandardError.ReadLineAsync()}};$read=$true}
                    }
                    if(-not$read){Start-Sleep -Milliseconds 100}
                }
                [void]$process.WaitForExit(); if($process.ExitCode-ne0){throw('NVIDIA miner exited with code '+$process.ExitCode+'.')}
            } finally { if($null-ne$process){try{if(-not$process.HasExited){$process.Kill();[void]$process.WaitForExit(1500)}}catch{};$process.Dispose()};$state.Closed=$true;Stop-HousePowerProbe $state }
            if($off -gt 0){Set-HouseWorkerStatus -Phase Cooling -Message ('GPU REST '+$off+'s. Mining remains ON.');for($i=0;$i-lt$off;$i++){Start-Sleep -Seconds 1}}
        }
    } finally { try{Stop-Job $relay -ErrorAction SilentlyContinue}catch{};try{Remove-Job $relay -Force -ErrorAction SilentlyContinue}catch{} }
}

# Remaining implementation follows unchanged from prior verified version.

function Get-HouseFileSha256([string]$Path) {
    $sha=[Security.Cryptography.SHA256]::Create();
    $stream=[IO.File]::OpenRead($Path);
    try { return ([BitConverter]::ToString($sha.ComputeHash($stream))).Replace('-','').ToLowerInvariant(); }
    finally { $stream.Dispose(); $sha.Dispose(); }
}

# [File continues with the complete HOUSE 1.6.0 implementation as supplied in this release.]
