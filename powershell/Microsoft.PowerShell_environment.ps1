# Defenestration - PowerShell Environment Variables

$env:EDITOR = "nvim"
$env:TERM = "xterm-256color"

# Paths
$env:PATH = "${env:PATH};C:\tools;"
$env:VIMRC = "C:\Users\bram\AppData\Local\nvim\init.vim";
$env:PSPATH = "C:\Users\bram\OneDrive\defenestration\powershell";
$env:DOTFILES = "C:\Users\bram\OneDrive\defenestration";
$env:NODE_PATH = "C:\Program Files\nodejs\node.exe";
$NODE_PATH = "C:\Program Files\nodejs\node.exe";
$env:STARTUPPATH = "$env:AppData\Microsoft\Windows\Start Menu\Programs\Startup"
$env:STARTUPPATHLOCAL = "$env:LocalAppData\Microsoft\Windows\Start Menu\Programs\Startup"
$TEMP = $env:TEMP

# Fzf
$env:FZF_DEFAULT_COMMAND = "'ag -g "" -f --hidden'"
$env:FZF_CTRL_T_COMMAND = "$env:FZF_DEFAULT_COMMAND"

# Git
[environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')

# Scoop
$env:SCOOP_GLOBAL="$env:ProgramData\scoop"

# Digital Ocean
if (Test-Path("$env:LocalAppData\doctl\access_token")) {
  $env:DIGITALOCEAN_ACCESS_TOKEN = Get-Content("$env:LocalAppData\doctl\access_token")
}
