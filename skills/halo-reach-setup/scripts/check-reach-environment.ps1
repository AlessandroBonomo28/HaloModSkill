[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$HrekRoot,

    [string]$MccRoot,

    [string]$ExcessionRoot,

    [switch]$Json
)

$ErrorActionPreference = 'Stop'

function Add-Check {
    param(
        [System.Collections.Generic.List[object]]$List,
        [string]$Component,
        [string]$Path,
        [bool]$Required,
        [ValidateSet('Leaf', 'Container')]
        [string]$PathType = 'Leaf'
    )

    $testType = if ($PathType -eq 'Container') { 'Container' } else { 'Leaf' }
    $List.Add([pscustomobject]@{
        Component = $Component
        Required  = $Required
        Found     = Test-Path -LiteralPath $Path -PathType $testType
        Path      = [System.IO.Path]::GetFullPath($Path)
    })
}

function Find-FirstFile {
    param(
        [string]$Root,
        [string[]]$RelativeCandidates
    )

    foreach ($relative in $RelativeCandidates) {
        $candidate = Join-Path -Path $Root -ChildPath $relative
        if (Test-Path -LiteralPath $candidate -PathType Leaf) {
            return [System.IO.Path]::GetFullPath($candidate)
        }
    }

    return [System.IO.Path]::GetFullPath((Join-Path -Path $Root -ChildPath $RelativeCandidates[0]))
}

$checks = [System.Collections.Generic.List[object]]::new()
$hrek = [System.IO.Path]::GetFullPath($HrekRoot)

Add-Check $checks 'HREK root' $hrek $true 'Container'
Add-Check $checks 'Sapien' (Join-Path $hrek 'sapien.exe') $true
Add-Check $checks 'Foundation' (Join-Path $hrek 'foundation.exe') $true
Add-Check $checks 'Tag Test' (Join-Path $hrek 'tag_test.exe') $false
Add-Check $checks 'ManagedBlam' (Join-Path $hrek 'bin\ManagedBlam.dll') $false
Add-Check $checks 'data directory' (Join-Path $hrek 'data') $true 'Container'
Add-Check $checks 'tags directory' (Join-Path $hrek 'tags') $true 'Container'
Add-Check $checks 'maps directory' (Join-Path $hrek 'maps') $true 'Container'

$toolFast = Join-Path $hrek 'tool_fast.exe'
$tool = Join-Path $hrek 'tool.exe'
$cacheBuilder = if (Test-Path -LiteralPath $toolFast -PathType Leaf) { $toolFast } else { $tool }
$checks.Add([pscustomobject]@{
    Component = 'Cache builder (tool_fast.exe or tool.exe)'
    Required  = $true
    Found     = (Test-Path -LiteralPath $toolFast -PathType Leaf) -or (Test-Path -LiteralPath $tool -PathType Leaf)
    Path      = [System.IO.Path]::GetFullPath($cacheBuilder)
})

if ($MccRoot) {
    $mcc = [System.IO.Path]::GetFullPath($MccRoot)
    Add-Check $checks 'MCC root' $mcc $false 'Container'
    $mccExe = Find-FirstFile $mcc @(
        'MCC\Binaries\Win64\MCC-Win64-Shipping.exe',
        'MCC-Win64-Shipping.exe'
    )
    Add-Check $checks 'MCC retail executable' $mccExe $false
}

if ($ExcessionRoot) {
    $excession = [System.IO.Path]::GetFullPath($ExcessionRoot)
    Add-Check $checks 'Excession root' $excession $false 'Container'
    Add-Check $checks 'Excession' (Join-Path $excession 'Excession.exe') $false
}

$missingRequired = @($checks | Where-Object { $_.Required -and -not $_.Found })
$result = [pscustomobject]@{
    Ready           = $missingRequired.Count -eq 0
    HrekRoot        = $hrek
    MissingRequired = @($missingRequired | ForEach-Object { $_.Component })
    Checks          = $checks
}

if ($Json) {
    $result | ConvertTo-Json -Depth 5
}
else {
    $checks | Format-Table Component, Required, Found, Path -AutoSize
    if ($result.Ready) {
        Write-Host 'HREK environment is ready.' -ForegroundColor Green
    }
    else {
        Write-Host ('Missing required components: ' + ($result.MissingRequired -join ', ')) -ForegroundColor Red
    }
}

if (-not $result.Ready) {
    exit 1
}

