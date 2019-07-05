# Defenestration - PowerShell profile

# PowerShell and Config

# Edit PowerShell profile
if (!(Get-Alias -ErrorAction SilentlyContinue pe)) {
  New-Alias -Name pe -Value Edit-Profile
}

# Edit vimrc
if (!(Get-Alias -ErrorAction SilentlyContinue ve)) {
  New-Alias -Name ve -Value Edit-Vimrc 
}

if (!(Get-Alias -ErrorAction SilentlyContinue which)) {
  New-Alias exp Explorer
}

# Unix
# [environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')

# which
if (!(Get-Alias -ErrorAction SilentlyContinue which)) {
  New-Alias which Get-Command
}

# wget
if ((Get-Alias -ErrorAction SilentlyContinue wget)) {
  Remove-Item alias:wget 
}

# cd - 
if ((Get-Alias -ErrorAction SilentlyContinue cd)) {
  Set-Alias -Name cd -Value pushd -Option AllScope
}
if ((Get-Alias -ErrorAction SilentlyContinue bd)) {
  Set-Alias -Name bd -Value popd -Option AllScope
}

# wc
if ((Get-Alias -ErrorAction SilentlyContinue wc)) {
  Set-Alias -Name wc -Value Measure-Object
}

# vi -> nvim
if ((Get-Command -ErrorAction SilentlyContinue vi) -Or (Get-Alias -ErrorAction SilentlyContinue vi)) {
  Set-Alias -Name vi -Value $env:EDITOR
}
