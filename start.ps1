# Defenestration - Installation

Write "
  ___  ____ ____ ____ _  _ ____ ____ ___ ____ ____ ___ _ ____ _  _ 
  |  \ |___ |___ |___ |\ | |___ [__   |  |__/ |__|  |  | |  | |\ | 
  |__/ |___ |    |___ | \| |___ ___]  |  |  \ |  |  |  | |__| | \| 
 
  Where do you want to go today?
"

# Set paths 
$rootPath = (Get-ScriptPath)
$scriptsPath = $rootPath + "\scripts"
$powerShellPath = $rootPath + "\powershell"
$chocolateyInstaller = $scriptsPath + "\chocolatey-install.ps1"
$powerShellFunctions = $powerShellPath + "\Microsoft.Powershell_functions.ps1"

write $chocolateyInstallerPath
write $powerShellFunctions

return

# 
if (Test-Path -Path $chocolateyInstallerPath) {
  & $chocolateyInstallerPath 
}

# Install Chocolatey
if ($isAdmin) {
  $chocolateyInstallerPath = ".\scripts\chocolatey-install.ps1"
  # Invoke-Item (start powershell ((Split-Path $MyInvocation.InvocationName) + "\scripts\chocolatey-install.ps1"))
} else {
  Write "Please open session with elevated rights."
}
