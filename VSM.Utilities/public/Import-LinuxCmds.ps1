function watch{
    param (
        [Parameter(Position=0)]
        [Int32] $seconds,
        [Parameter(Position=1)]
        [scriptblock]$command
    )
    $loop = $true
    while($True -eq $loop){
        $command.Invoke()
        Start-Sleep -Seconds $seconds
        Clear-Host
    }
}
function touch{
    param (
        [Parameter()]
        [string] $FileName
    )
    "" | Out-File $FileName -Encoding ASCII
}
function ff{
    param (
        [Parameter()]
        [string] $name
    )
    Get-ChildItem -Recurse -Filter "*${name}*" -ErrorAction SilentlyContinue | 
    ForEach-Object {
        Write-Output "$($_.directory)\$($_)"
    }
}
# Network Utilities
function Get-PubIP {
    (Invoke-WebRequest http://ifconfig.me/ip).Content
}

# System Utilities
function uptime {
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
    } else {
        net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
    }
}

function Reload-Profile {
    & $profile
}

function unzip ($file) {
    
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function hb {
    if ($args.Length -eq 0) {
        Write-Error "No file path specified."
        return
    }
    
    $FilePath = $args[0]
    
    if (Test-Path $FilePath) {
        $Content = Get-Content $FilePath -Raw
    } else {
        Write-Error "File path does not exist."
        return
    }
    
    $uri = "http://bin.christitus.com/documents"
    try {
        $response = Invoke-RestMethod -Uri $uri -Method Post -Body $Content -ErrorAction Stop
        $hasteKey = $response.key
        $url = "http://bin.christitus.com/$hasteKey"
        Write-Output $url
    } catch {
        Write-Error "Failed to upload the document. Error: $_"
    }
}
function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function df {
    get-volume
}

function sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
    Get-Process $name
}

function head {
param(
    $Path,
    $n = 10
)
  Get-Content $Path -Head $n
}

function tail {
param(
    $Path,
    $n = 10
)
  Get-Content $Path -Tail $n
}

# Quick File Creation
function nf {
param(
    $name
) 
    New-Item -ItemType "file" -Path . -Name $name 
}

# Directory Management
function mkcd {
param(
    $dir
) 
    mkdir $dir -Force
    Set-Location $dir 
}

# Simplified Process Management
function k9 { Stop-Process -Name $args[0] }

# Enhanced Listing
function la {
    Get-ChildItem -Path . -Force | Format-Table -AutoSize
}
function ll {
    Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize
}

# Git Shortcuts
function gs {
    git status 
}

function ga {
    git add . 
}

function gc {
param(
    $m
)
    git commit -m "$m" 
}

function gp {
    git push 
}

function gcom {
    git add .
    git commit -m "$args"
}
function lazyg {
    git add .
    git commit -m "$args"
    git push
}

# Quick Access to System Information
function sysinfo { 
    Get-ComputerInfo 
}

# Networking Utilities
function flushdns {
    Clear-DnsClientCache
}

# Clipboard Utilities
function cpy {
    Set-Clipboard $args[0] 
}

function pst {
    Get-Clipboard
}