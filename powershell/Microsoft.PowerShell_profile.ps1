# PowerShell profile

# Shell size
$Shell = $Host.UI.RawUI
$size = $Shell.WindowSize
$size.width=70
$size.height=55
 
# Environment variables
$env:TERM = "xterm-256color"
$env:EDITOR = "nvim"

# Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
 
# General #####################################################################
############################################################################### 
 
# Set starting prompt location
set-location $ENV:USERPROFILE

# Set up command prompt and window title. Use UNIX-style convention for identifying 
# whether user is elevated (root) or not. Window title shows current version of PowerShell
# and appends [ADMIN] if appropriate for easy taskbar identification
function prompt() { 
    {
        "" + (Get-Location) + " # " 
    }
    else 
    {
        "" + (Get-Location) + " $ "
    }
}

$Host.UI.RawUI.WindowTitle = "PowerShell {0}" -f $PSVersionTable.PSVersion.ToString()
if ($isAdmin) {
    $Host.UI.RawUI.WindowTitle += " [root]"
}

# Aliases #####################################################################
###############################################################################

# Set UNIX-like aliases for the admin command
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin

# Edit PowerShell profile
if (!(Get-Alias pe)) {
  New-Alias -Name pe -Value edit-profile
}

# which
if (!(Get-Alias which)) {
  New-Alias which get-command
}

# unix tools PowerShell equivalents

# Edit profile
function edit-profile() {
  nvim $PROFILE
}

# Grep alternative
# function grep($pattern) {
#     $MyArgs=(Join-Path $ENV:HOME "bin\scr"),$args
#     if($MyInvocation.ExpectingInput){
#         python @MyArgs
#     }
# }  

# ln -s /path/to/file /path/to/link
function make-link($target, $link) {
  New-Item -Path $link -ItemType SymbolicLink -Value $target
}


# wget
# Create custom function for wget and unset the alias 
# Remove-Alias wget (doens't work)
function wwwget($url, $filename) {

  write "this is wwwget"

  sleep 3
  
  if (!($url)) {
    write "Please provide at least a url URL."
    write ""
    write "Usage:"
    write "wwwget http://website.com/image.jpg"
    write "Or with a different filename:"
    write "wwwget http://website.com/image.jpg C:\Files\picture.jpg"
    exit
  }

  if (!$filename) {
    $filename = "./" + $url.Substring($URL.LastIndexOf("/") + 1)
  }
  Invoke-Webrequest -Uri $url -OutFile $filename
}

function Get-Uptime() {
  $os = Get-WmiObject win32_operatingsystem
  $uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
  $Display = "Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes" 
  Write-Output $Display
}

function Virtualize-Disk($user, $vmDirName, $vmdkFileName) {
  if (!$user) {
    $user = $USER
  }
  if (!$vmDirName) {
    exit
  }
  VBoxManage internalcommands createrawvmdk -filename "C:\Users\<user_name>\VirtualBox VMs\<VM_folder_name>\<file_name>.vmdk" -rawdisk \\.\PhysicalDrive#
}
# docker-machine-create-generic
# function docker-machine-create-generic($ip, $user, $key, $name) {
#   if (!($ip || $user || $key || $name)) {
#     echo "$ip || $user || $key || $name was missing, bye!"
#     exit
#   }
#   echo $ip
#   echo $user
#   echo $key
#   echo $name
#   echo "docker-machine create --driver generic --generic-ip-address=$ip --generic-ssh-user $user --generic-ssh-key $key $name"
# }

# Delete temporary variables used to set $isAdmin
Remove-Variable identity
Remove-Variable principal

# Clean up
#Clear-Host
