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
    yt-dlp --extract-audio --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" $args
}
Set-Alias da download-audio

function sync-music() {
    cd E:\Music\
    spotdl sync https://music.youtube.com/browse/VLPLg3vjVhK1vnYQWB26nwADGqEf2xHzgSZR --save-file data.spotdl  --audio youtube-music --bitrate auto --sponsor-block
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

function GenerateM3U {
    param(
        [System.IO.DirectoryInfo] $directory,
        [string] $destinationPath
    )

    # Ensure the destination path exists
    if (-not (Test-Path $destinationPath)) {
        New-Item -Path $destinationPath -ItemType Directory -Force
    }

    # Define the playlist file name
    $playlistFileName = "Nulloy.m3u"
    $playlistPath = Join-Path -Path $destinationPath -ChildPath $playlistFileName

    # Remove old playlist file if it exists
    if (Test-Path $playlistPath) {
        Remove-Item $playlistPath
    }

    # Get all MP3 files in the directory and write to the playlist
    $directory.GetFiles("*.mp3") |
    ForEach-Object { $_.FullName } |
    Sort-Object |
    Out-File -Encoding UTF8 -FilePath $playlistPath

    Write-Host "Created M3U Playlist: $playlistPath"
}

function syncPlaylist {
    $musicDirectory = "E:\Music"
    $musicDirInfo = Get-Item $musicDirectory

    $destinationPath = "C:\Users\master\AppData\Roaming\Nulloy"
    GenerateM3U -directory $musicDirInfo -destinationPath $destinationPath
}

function ls-mb() {
    ls | Select-Object Name, @{Name="MegaBytes";Expression={$_.Length / 1MB}}
}

function ls-kb() {
    ls | Select-Object Name, @{Name="KiloBytes";Expression={$_.Length / 1KB}}
}

new-alias grep select-string

new-alias unzip Expand-Archive

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
