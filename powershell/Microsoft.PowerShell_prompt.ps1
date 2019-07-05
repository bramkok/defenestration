# Defenestration - PowerShell prompt
#
# Set up command prompt and window title. Use UNIX-style convention for identifying 
# whether user is elevated (root) or not. Window title shows current version of PowerShell
# and appends [ADMIN] if appropriate for easy taskbar identification
#
# function prompt() { 
#   {
#       "" + (Get-Location) + " # " 
#   } else {
#       "" + (Get-Location) + " $ "
#   }
# }

function prompt {
    $currentDirectory = $(Get-Location)
    $UncRoot = $currentDirectory.Drive.DisplayRoot

    write-host " $UncRoot" -ForegroundColor Gray

    # Convert-Path needed for pure UNC-locations
    write-host "$(Convert-Path $currentDirectory)>" -NoNewline -ForegroundColor Yellow
    return " "
}
