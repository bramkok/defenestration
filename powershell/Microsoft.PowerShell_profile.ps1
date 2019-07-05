# Defenestration - PowerShell profile

$ProfileInfo = Get-Item $PROFILE
$global:ProfileDebug = $false 

if (($ProfileInfo).LinkType -eq "SymbolicLink") {
  $ProfileScriptsPath = Split-Path $ProfileInfo.Target
} else {
  $ProfileScriptsPath = Split-Path $ProfileInfo.FullName
}

if (Test-Path("$ProfileScriptsPath\debug")) {
  $global:ProfileDebug = [System.Convert]::ToInt16(
    (Get-Content("$ProfileScriptsPath\debug"))
  )
  if ([System.Convert]::ToBoolean($global:ProfileDebug)) { $global:ProfileDebug = $true }
}

function Source-PSScript($filename) {
  if (Test-Path("$profilescriptspath\$filename")) { . "$profilescriptspath\$filename" }
}

# Load modules
Import-Module posh-git -ErrorAction SilentlyContinue
Import-Module z -ErrorAction SilentlyContinue
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }

# Source profile scripts
. Source-PSScript "Microsoft.PowerShell_functions.ps1"
. Source-PSScript "Microsoft.PowerShell_prompt.ps1"
. Source-PSScript "Microsoft.PowerShell_environment.ps1"
. Source-PSScript "Microsoft.PowerShell_aliases.ps1"
. Source-PSScript "Microsoft.PowerShell_local.ps1"

# Shell settings
Set-Location $env:USERPROFILE
Set-PSReadlineOption -BellStyle None

# ViMode
Set-PsReadlineOption -EditMode Vi -ViModeIndicator Cursor -HistoryNoDuplicate
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Key Ctrl+n -Function Complete
Set-PSReadlineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory -ViMode Insert
Set-PSReadlineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory -ViMode Command

# Reload profile
function Reload-Profile() {
  if ($global:ProfileDebug) { Write "Debug info: $global:ProfileDebug. Sourcing $PROFILE" }
  . $PROFILE
  if ($global:ProfileDebug) { Write "Sourcing other profile files."; Write "Importing the following modules:" }
  $loadedModules = (Get-Module)
  if ($global:ProfileDebug) { Write $loadedModules }
  Write $loadedModules | Import-Module
  Write "
    PowerShell profile files and modules have been reloaded.
  "
  Power-Nap
  if (!($global:ProfileDebug)) { Clear-Host }
}

# Clear
if (!($global:ProfileDebug)) { Clear-Host } else { Write "" }
