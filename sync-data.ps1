function auto-git-commit() {
    git add .
    git commit -m "Auto commit"
    git pull
    git push
}

cd C:\Users\master\repos\cutbypham\rss-to-email-once-a-day\
auto-git-commit
cd -

cd E:\Music\
spotdl sync https://music.youtube.com/browse/VLPLg3vjVhK1vnYQWB26nwADGqEf2xHzgSZR --save-file data.spotdl --audio youtube-music --bitrate auto --sponsor-block
cd -

Write-Host "Music synchronization completed."

# Define the music directory and destination path for the playlist
$musicDirectory = "E:\Music"
$destinationPath = "C:\Users\master\AppData\Roaming\Nulloy"
$playlistFileName = "Nulloy.m3u"
$playlistPath = Join-Path -Path $destinationPath -ChildPath $playlistFileName

# Ensure the destination path exists
if (-not (Test-Path $destinationPath)) {
    New-Item -Path $destinationPath -ItemType Directory -Force
}

# Remove old playlist file if it exists
if (Test-Path $playlistPath) {
    Remove-Item $playlistPath
}

# Get all MP3 files in the music directory and write to the playlist
$musicDirInfo = Get-Item $musicDirectory
$musicDirInfo.GetFiles("*.mp3") |
ForEach-Object { $_.FullName } |
Sort-Object |
Out-File -Encoding UTF8 -FilePath $playlistPath

Write-Host "Created M3U Playlist: $playlistPath"

cd C:\Users\master\repos\cutbypham\davinci-resolve
auto-git-commit

cd C:\Users\master\repos\cutbypham\obs-studio\
auto-git-commit

cp $profile ~\repos\cutbypham\dotfiles\
cp C:\Users\master\AppData\Local\nvim\init.lua ~\repos\cutbypham\dotfiles\nvim
cp C:\Users\master\.gitconfig ~\repos\cutbypham\dotfiles\
cp C:\Users\master\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json ~\repos\cutbypham\dotfiles\windows-terminal\
cp C:\Users\master\AppData\Roaming\Mozilla\Firefox\Profiles\3wr0grx7.default-release\user.js ~\repos\cutbypham\dotfiles\

cd C:\Users\master\repos\cutbypham\dotfiles
auto-git-commit
