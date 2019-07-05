# Defenestration - PowerShell Functions

# which
function which($name) {
  Get-Command $name | Select-Object -ExpandProperty Definition
}

# Fuzzy Find History
function Fzf-Hist() {
  Invoke-Expression (cat (Get-PSReadlineOption | select -ExpandProperty historysavepath) | Invoke-Fzf)
}

# Check if the current user has admin rights
function Is-Admin() {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Get path of current script
function Get-ScriptPath() {
  return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('.\')
}

# Edit powershell profile
function Edit-Profile() {
  nvim "$PROFILE"
}

# Edit vimrc
function Edit-Vimrc() {
  if (Test-Path($env:VIMRC)) {
    nvim "$env:VIMRC"
  }
}

# ln -s /path/to/file /path/to/link
function Make-Link($target, $link) {
  New-Item -Path $link -ItemType SymbolicLink -Value $target
}

# wget
function wget($url, $filename) {
  if (!($url)) {
    write "Please provide at least a url URL."
    write ""
    write "Usage:"
    write "wget http://website.com/image.jpg"
    write "Or with a different filename:"
    write "wget http://website.com/image.jpg C:\Files\picture.jpg"
    write ""
    return
  }

  if (!$filename) {
    $filename = "./" + $url.Substring($URL.LastIndexOf("/") + 1)
  }
  Invoke-Webrequest -Uri $url -OutFile $filename
}

# Get uptime
function Get-Uptime() {
  $os = Get-WmiObject win32_operatingsystem
  $uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
  $Display = "Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes" 
  Write-Output $Display
}

# l - Get child items names only
function l($path) {
  if (!($path)) {
    $path = $PWD
  }
  Get-ChildItem -Name $path
}

# PowerNap - Sleep in milliseconds
function Power-Nap($milliseconds) {
  if (!($milliseconds)) {
    $milliseconds = 500 
  }
  Start-Sleep -Milliseconds $milliseconds
}

# List all coreutils shims installed with scoop
function List-CoreUtils() {
  Write "
  Creating shim for 'basename'.
  Creating shim for 'cat'.
  Creating shim for 'chmod'.
  Creating shim for 'comm'.
  Creating shim for 'cp'.
  Creating shim for 'cut'.
  Creating shim for 'date'.
  Creating shim for 'dirname'.
  Creating shim for 'echo'.
  Creating shim for 'env'.
  Creating shim for 'expr'.
  Creating shim for 'false'.
  Creating shim for 'fold'.
  Creating shim for 'head'.
  Creating shim for 'id'.
  Creating shim for 'install'.
  Creating shim for 'join'.
  Creating shim for 'ln'.
  Creating shim for 'ls'.
  Creating shim for 'md5sum'.
  Creating shim for 'mkdir'.
  Creating shim for 'msysmnt'.
  Creating shim for 'mv'.
  Creating shim for 'od'.
  Creating shim for 'paste'.
  Creating shim for 'printf'.
  Creating shim for 'ps'.
  Creating shim for 'pwd'.
  Creating shim for 'rm'.
  Creating shim for 'rmdir'.
  Creating shim for 'sleep'.
  Creating shim for 'sort'.
  Creating shim for 'split'.
  Creating shim for 'stty'.
  Creating shim for 'tail'.
  Creating shim for 'tee'.
  Creating shim for 'touch'.
  Creating shim for 'tr'.
  Creating shim for 'true'.
  Creating shim for 'uname'.
  Creating shim for 'uniq'.
  Creating shim for 'wc'."
}

# youtube-dl
function ydl($url, $height) {
  #if (($height) -And 
  youtube-dl -f "bestvideo[height<=$height]+bestaudio/best[height<=$height]" "$url"
}

<#

Returns true if a program with the specified display name is installed.
This function will check both the regular Uninstall location as well as the
"Wow6432Node" location to ensure that both 32-bit and 64-bit locations are
checked for software installations.

@param String $program The name of the program to check for.
@return Booleam Returns true if a program matching the specified name is installed.

#>
function Is-Installed( $program ) {
    
    $x86 = ((Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall") |
        Where-Object { $_.GetValue( "DisplayName" ) -like "*$program*" } ).Length -gt 0;

    $x64 = ((Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall") |
        Where-Object { $_.GetValue( "DisplayName" ) -like "*$program*" } ).Length -gt 0;

    return $x86 -or $x64;
}

# Search for apps
function Search-App($query, $sources) {
  if (!$query) {
    Write "
  Search-App

  Find apps in Chocolatey and scoop repositories.

  Usage:

    $ $myInvocation.MyCommand.Name <appname>
    "
    return
  }
  if (Test-Path $env:SCOOP_GLOBAL) {
    Write "Searching with scoop for '$query':"
    scoop search $query
  } else {
    Write "Unable to find scoop. Install scoop for more results"
  }
  if ([Environment]::GetEnvironmentVariable("ChocolateyInstall")) {
    Write "Searching with Chocolatey for '$query':"
    choco search $query --id-only -r
  } else {
    Write "Unable to find Chocolatey. Install Chocolatey for more results"
  }
  Write "Search for '$query' completed."
}
