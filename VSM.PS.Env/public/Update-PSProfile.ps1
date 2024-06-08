function Update-PSProfile {
    [CmdletBinding()]
    param (
        
    )
 # Initial GitHub.com connectivity check with 1 second timeout
$GitHubPageStatus = Test-Connection github.com -Count 1 -Quiet -TimeoutSeconds 1

if (-not $global:canConnectToGitHub) {
    Write-Host "Skipping profile update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
    return
}

try {
    $url = "https://raw.githubusercontent.com/victorxz90044/powershell-profile/main/Microsoft.PowerShell_profile.ps1"
    $oldhash = Get-FileHash $PROFILE
    Invoke-RestMethod $url -OutFile "$env:temp/Microsoft.PowerShell_profile.ps1"
    $newhash = Get-FileHash "$env:temp/Microsoft.PowerShell_profile.ps1"
    if ($newhash.Hash -ne $oldhash.Hash) {
        Copy-Item -Path "$env:temp/Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
        Write-Host "Profile has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
    }
} catch {
    Write-Error "Unable to check for `$profile updates"
} finally {
    Remove-Item "$env:temp/Microsoft.PowerShell_profile.ps1" -ErrorAction SilentlyContinue
}
}
