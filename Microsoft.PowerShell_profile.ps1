# try { $null = gcm pshazz -ea stop; pshazz init 'default' } catch { }
Import-Module posh-git
Import-Module oh-my-posh
Import-Module DirColors
Import-Module ZLocation

Set-Theme robbyrussell
Update-DirColors ~\_dircolors-256

function __pwd__ {
	(Get-Location).Path | echo
}

Remove-Item alias:\pwd -Force
Set-Alias wh where.exe
Set-Alias which wh
Set-Alias pwd __pwd__
Set-Alias greep ag
Set-Alias nvq nvim-qt.exe
Set-Alias vi vim.exe
Set-Alias python37 C:\\Python37\\python.exe

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
