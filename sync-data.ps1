function auto-git-commit() {
    git add .
    git commit -m "Auto commit"
    git pull
    git push
}

cd E:\Music\
yt-dlp --cookies-from-browser firefox --download-archive archive.txt --extract-audio --audio-format mp3 --embed-thumbnail --embed-metadata --add-metadata -o "%(title)s.%(ext)s" "https://music.youtube.com/playlist?list=PLg3vjVhK1vnYQWB26nwADGqEf2xHzgSZR"
cd -

cp $profile ~\repos\dotfiles\
cp C:\Users\master\AppData\Local\nvim\init.lua ~\repos\dotfiles\nvim
cp C:\Users\master\.gitconfig ~\repos\dotfiles\
cp C:\Users\master\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json ~\repos\dotfiles\windows-terminal\
cp C:\Users\master\AppData\Roaming\Mozilla\Firefox\Profiles\3wr0grx7.default-release\user.js ~\repos\dotfiles\

cd C:\Users\master\repos\dotfiles
auto-git-commit

cd C:\Users\master\repos\davinci-resolve\
auto-git-commit

#############################################################
#############################################################
#############################################################

$LogFile = "C:\Users\master\Documents\sync-data-log.txt"

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    $entry = "$timestamp $Message"
    Add-Content -Path $LogFile -Value $entry -Encoding UTF8
}

Write-Log "Script finished"
