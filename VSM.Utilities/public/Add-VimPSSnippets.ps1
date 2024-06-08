function Add-VimPSSnippets {
<#
.SYNOPSIS
  This function will create a PowerShell entry in friendly-snippets for LunarVim  
.DESCRIPTION
  A longer description of the function, its purpose, common use cases, etc.
.NOTES
  Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
  Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
  Test-MyTestFunction -Verbose
  Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>

[CmdletBinding()]
param (
  [Parameter(Position=0)]
  [string]$SourceUri = "https://raw.githubusercontent.com/rafamadriz/friendly-snippets/main/snippets/PowerShell.json" 
)
#download json
Set-Location ~\Documents
Invoke-WebRequest -Uri $SourceUri -OutFile PowerShell.json
$PSJsonFilePath = Get-ChildItem .\PowerShell.json | Select-Object -ExpandProperty FullName
# copy file to path
Copy-Item $PSJsonFilePath ~\AppData\Roaming\lunarvim\site\pack\lazy\opt\friendly-snippets\snippets\PowerShell.json
# update package.json
$FSPackage = Get-Content ~\AppData\Roaming\lunarvim\site\pack\lazy\opt\friendly-snippets\package.json | ConvertFrom-Json -AsHashtable
$FSPackageFilePath = ~\AppData\Roaming\lunarvim\site\pack\lazy\opt\friendly-snippets\package.json
$SnippetEntry = '{
         "language": ["PowerShell","ps1"],
         "path": "./snippets/PowerShell.json"
       }' | ConvertFrom-Json
$FSPackage.contributes.snippets += $SnippetEntry
$FSPackage | ConvertTo-Json $FSPackageFilePath -Depth 4 

}
