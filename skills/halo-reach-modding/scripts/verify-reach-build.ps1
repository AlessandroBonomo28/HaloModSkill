[CmdletBinding()]
param(
    [string]$CanonicalHsc,

    [string]$HrekHsc,

    [Parameter(Mandatory = $true)]
    [string]$ScenarioTag,

    [Parameter(Mandatory = $true)]
    [string]$MapFile,

    [Parameter(Mandatory = $true)]
    [string]$BuildLog,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Probe,

    [string[]]$ForbiddenLogPattern = @(),

    [string]$LocalizedTag,

    [string]$ExpectedLocalizedHash,

    [switch]$Json
)

$ErrorActionPreference = 'Stop'

function Test-AsciiMarker {
    param(
        [string]$Path,
        [string]$Marker
    )

    $needleLength = [System.Text.Encoding]::ASCII.GetByteCount($Marker)
    if ($needleLength -eq 0) { return $false }

    $stream = [System.IO.File]::Open($Path, 'Open', 'Read', 'ReadWrite')
    try {
        $buffer = [byte[]]::new(4MB)
        $carry = ''
        while (($read = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) {
            $chunk = $carry + [System.Text.Encoding]::ASCII.GetString($buffer, 0, $read)
            if ($chunk.IndexOf($Marker, [System.StringComparison]::Ordinal) -ge 0) {
                return $true
            }

            $carryLength = [Math]::Min([Math]::Max($needleLength - 1, 0), $chunk.Length)
            if ($carryLength -gt 0) {
                $carry = $chunk.Substring($chunk.Length - $carryLength)
            }
            else {
                $carry = ''
            }
        }
    }
    finally {
        $stream.Dispose()
    }

    return $false
}

function Add-Result {
    param(
        [System.Collections.Generic.List[object]]$List,
        [string]$Check,
        [bool]$Passed,
        [string]$Detail
    )

    $List.Add([pscustomobject]@{
        Check  = $Check
        Passed = $Passed
        Detail = $Detail
    })
}

if ([bool]$CanonicalHsc -xor [bool]$HrekHsc) {
    throw 'Pass both CanonicalHsc and HrekHsc, or omit both for a tag-only build.'
}

if ([bool]$LocalizedTag -xor [bool]$ExpectedLocalizedHash) {
    throw 'Pass both LocalizedTag and ExpectedLocalizedHash, or omit both.'
}

$results = [System.Collections.Generic.List[object]]::new()
$requiredPaths = @{
    'Scenario tag exists' = $ScenarioTag
    'Map file exists'     = $MapFile
    'Build log exists'    = $BuildLog
}

foreach ($entry in $requiredPaths.GetEnumerator()) {
    $exists = Test-Path -LiteralPath $entry.Value -PathType Leaf
    Add-Result $results $entry.Key $exists ([System.IO.Path]::GetFullPath($entry.Value))
}

if (@($results | Where-Object { -not $_.Passed }).Count -eq 0) {
    if ($CanonicalHsc) {
        $canonicalExists = Test-Path -LiteralPath $CanonicalHsc -PathType Leaf
        $hrekExists = Test-Path -LiteralPath $HrekHsc -PathType Leaf
        Add-Result $results 'Canonical HSC exists' $canonicalExists ([System.IO.Path]::GetFullPath($CanonicalHsc))
        Add-Result $results 'HREK HSC exists' $hrekExists ([System.IO.Path]::GetFullPath($HrekHsc))

        if ($canonicalExists -and $hrekExists) {
            $canonicalHash = (Get-FileHash -LiteralPath $CanonicalHsc -Algorithm SHA256).Hash
            $hrekHash = (Get-FileHash -LiteralPath $HrekHsc -Algorithm SHA256).Hash
            Add-Result $results 'HSC hashes match' ($canonicalHash -eq $hrekHash) "canonical=$canonicalHash; hrek=$hrekHash"

            $scenarioTime = (Get-Item -LiteralPath $ScenarioTag).LastWriteTimeUtc
            $hscTime = (Get-Item -LiteralPath $HrekHsc).LastWriteTimeUtc
            Add-Result $results 'Scenario saved after HSC' ($scenarioTime -gt $hscTime) "scenario=$($scenarioTime.ToString('o')); hsc=$($hscTime.ToString('o'))"
        }
    }

    Add-Result $results 'Probe present in scenario' (Test-AsciiMarker $ScenarioTag $Probe) $Probe
    Add-Result $results 'Probe present in map' (Test-AsciiMarker $MapFile $Probe) $Probe

    $logText = Get-Content -LiteralPath $BuildLog -Raw
    $success = $logText -match '(?i)successfully built cache file'
    Add-Result $results 'Build success line present' $success 'successfully built cache file'

    $defaultForbidden = @('script compile errors')
    foreach ($pattern in @($defaultForbidden + $ForbiddenLogPattern)) {
        if ([string]::IsNullOrWhiteSpace($pattern)) { continue }
        $found = $logText.IndexOf($pattern, [System.StringComparison]::OrdinalIgnoreCase) -ge 0
        Add-Result $results "Build log excludes: $pattern" (-not $found) $(if ($found) { 'found' } else { 'not found' })
    }

    if ($LocalizedTag) {
        $localizedExists = Test-Path -LiteralPath $LocalizedTag -PathType Leaf
        Add-Result $results 'Localized tag exists' $localizedExists ([System.IO.Path]::GetFullPath($LocalizedTag))
        if ($localizedExists) {
            $actualLocalizedHash = (Get-FileHash -LiteralPath $LocalizedTag -Algorithm SHA256).Hash
            Add-Result $results 'Localized tag hash matches' ($actualLocalizedHash -eq $ExpectedLocalizedHash.ToUpperInvariant()) "actual=$actualLocalizedHash; expected=$($ExpectedLocalizedHash.ToUpperInvariant())"
        }
    }
}

$scenarioHash = if (Test-Path -LiteralPath $ScenarioTag -PathType Leaf) { (Get-FileHash -LiteralPath $ScenarioTag -Algorithm SHA256).Hash } else { $null }
$mapHash = if (Test-Path -LiteralPath $MapFile -PathType Leaf) { (Get-FileHash -LiteralPath $MapFile -Algorithm SHA256).Hash } else { $null }
$failed = @($results | Where-Object { -not $_.Passed })
$summary = [pscustomobject]@{
    Passed       = $failed.Count -eq 0
    Probe        = $Probe
    ScenarioHash = $scenarioHash
    MapHash      = $mapHash
    FailedChecks = @($failed | ForEach-Object { $_.Check })
    Checks       = $results
}

if ($Json) {
    $summary | ConvertTo-Json -Depth 5
}
else {
    $results | Format-Table Check, Passed, Detail -AutoSize
    Write-Host "Scenario SHA-256: $scenarioHash"
    Write-Host "Map SHA-256:      $mapHash"
    if ($summary.Passed) {
        Write-Host 'Build verification passed.' -ForegroundColor Green
    }
    else {
        Write-Host ('Build verification failed: ' + ($summary.FailedChecks -join ', ')) -ForegroundColor Red
    }
}

if (-not $summary.Passed) {
    exit 1
}

