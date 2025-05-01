Set-PSReadLineOption -EditMode vi

$env:EDITOR = 'nvim'

Set-Alias chrome 'C:\Program Files\Google\Chrome\Application\chrome.exe'

function v() {
    nvim .
}

function edit-startscript() {
    nvim "C:\Users\master\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startup-script.bat"
}

function change-dir-fzf() {
    $folder = fd --type directory --exclude scoop --exclude go --exclude .vscode --exclude bundle --exclude .git --exclude gems --exclude node_modules | fzf --height 50% --min-height 20 --reverse
    Set-Location $folder
}
Set-Alias c change-dir-fzf

function cc() {
    cd
    change-dir-fzf
}

function firefox-profile() {
    cd C:\Users\master\AppData\Roaming\Mozilla\Firefox\Profiles\ouyze0q0.default
}

function edit-file-fzf() {
    $file = fd --hidden --type file . | fzf --height 50% --min-height 20 --reverse
    nvim $file
}
Set-Alias e edit-file-fzf

function edit-powershell-config() { nvim $profile }

function edit-nvim-config() { nvim C:\Users\master\AppData\Local\nvim\init.lua }

function d() {
    aria2c --max-connection-per-server=16 --split=10 --enable-http-pipelining=true --max-overall-download-limit=0 --file-allocation=falloc --disk-cache=32M --seed-time=0 "$args"
}

function update-dotfiles() {
    cp $profile ~\repos\cutbypham\dotfiles\
    cp C:\Users\master\AppData\Local\nvim\init.lua ~\repos\cutbypham\dotfiles\nvim
    cd ~\repos\cutbypham\dotfiles\
    git add Microsoft.PowerShell_profile.ps1
    git add nvim\init.lua
    git commit -m "pwsh, nvim"
    git push
    cd -
}

Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource History

function q() { Exit }

function s() { git status --short --branch }

function git-commit {
    git status --short --branch
    git diff
    git add .
    git commit 
}
Set-Alias a git-commit

function auto-git-commit() {
    git add .
    git commit -m "👌Auto commit"
    git pull
    git push
}
Set-Alias aa auto-git-commit

function auto-git-commit-format() {
    pnpm format
    git add .
    git commit -m "👌Auto commit"
    git pull
    git push
}
Set-Alias aaa auto-git-commit-format

function p() { git push }

function Get-ChildItem-Hidden() { Get-ChildItem -Force }
Set-Alias ls Get-ChildItem-Hidden
Set-Alias l Get-ChildItem-Hidden

function Get-ChildItem-Hidden-Wide() { Get-ChildItem -Force | Format-Wide }
Set-Alias la Get-ChildItem-Hidden-Wide

function .. { Set-location .. }

function ... { Set-location .. ; Set-location .. }

function tmp() {
    Set-location -Path $env:temp
}

function dow() {
    Set-location -Path $env:USERPROFILE\Downloads\
}

function doc() {
    Set-location -Path $env:USERPROFILE\Documents\
}

function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function update() {
    winget upgrade --all
    update-dotfiles
}

function download-video( ) {
    yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $args
}
Set-Alias dv download-video
Set-Alias y yt-dlp

function download-audio() {
    yt-dlp --extract-audio --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" "$args"
}
Set-Alias da download-audio

function download-thumbnail() {
    yt-dlp --skip-download --write-thumbnail --convert-thumbnails png "$args"
}
Set-Alias dt download-thumbnail

function sync-music() {
    cd E:\Music\
yt-dlp --cookies-from-browser firefox --download-archive archive.txt --extract-audio --audio-format mp3 --embed-thumbnail --embed-metadata --add-metadata -o "%(title)s.%(ext)s" "https://music.youtube.com/playlist?list=PLg3vjVhK1vnYQWB26nwADGqEf2xHzgSZR"
    cd -
}

function download-youtube-video-to-watch-offline() {
    mkdir ~\Downloads\YouTube\ > $null 2>&1
    cd ~\Downloads\YouTube\
    yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' (Get-Clipboard)
    cd -
}
function yy() {
    download-youtube-video-to-watch-offline
    exit
}

function ls-mb() {
    ls | Select-Object Name, @{Name="MegaBytes";Expression={$_.Length / 1MB}}
}

function ls-kb() {
    ls | Select-Object Name, @{Name="KiloBytes";Expression={$_.Length / 1KB}}
}

new-alias grep select-string

new-alias unzip Expand-Archive

Set-PSReadLineOption -EditMode Windows
$PSDefaultParameterValues['Out-File:NoClobber'] = $true
function Set-Location {
    param(
        [string]$Path
    )
    Microsoft.PowerShell.Management\Set-Location $Path
    Write-Host "`e]9;9;$(Get-Location)`a"
}

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
            $Local:ast = $commandAst.ToString().Replace('"', '""')
            winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
            }
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
