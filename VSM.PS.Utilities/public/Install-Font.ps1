function Install-NerdFont {
[CmdletBinding()]
param (
[string] $font = "Hasklig"         
)

Install-Module -Name WindowsConsoleFonts
https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hasklig.zip

$files = unzip Hasklig.zip
Remove-item Hasklig.zip 
foreach($file in $files){
    Add-Font $file 
    Remove-Item $file
}
if()
Set-ConsoleFont "Hasklug Nerd Font Mono"   
}




