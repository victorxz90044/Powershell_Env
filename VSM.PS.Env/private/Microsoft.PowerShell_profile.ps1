
Update-PSProfile
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Set-PSReadLineOption -Colors @{
    Command = 'Cyan'
    Parameter = 'Magenta'
    String = 'Yellow'
}

if(!(Get-Process PowerToys.KeyboardManagerEngine)){
   & 'C:\Program Files\PowerToys\KeyboardManagerEngine\PowerToys.KeyboardManagerEngine.exe'
}
#FilePaths
## Github
$GHPath = "$env:USERPROFILE\Documents\Github\"

## NeoVim
$NvimConfig = "$env:USERPROFILE\AppData\Local\nvim"

## LunarVim
$LvimConfig   = $env:LUNARVIM_BASE_DIR
$LvimPlugins  = "$env:LUNARVIM_BASE_DIR\lua\lvim"
$LVimSnippets = "$env:APPDATA\lunarvim\site\pack\lazy\opt\friendly-snippets\snippets"

## Final Line to set prompt
oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/cobalt2.omp.json | Invoke-Expression
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
} else {
    Write-Host "zoxide command not found. Attempting to install via winget..."
    try {
        winget install -e --id ajeetdsouza.zoxide
        Write-Host "zoxide installed successfully. Initializing..."
        Invoke-Expression (& { (zoxide init powershell | Out-String) })
    } catch {
        Write-Error "Failed to install zoxide. Error: $_"
    }
}