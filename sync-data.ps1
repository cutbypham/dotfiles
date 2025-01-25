function auto-git-commit() {
    git add .
    git commit -m "Auto commit"
    git pull
    git push
}

function Create-MusicPlaylist {
    param (
        [string]$PlaylistName = "nulloy.m3u",
        [string[]]$Extensions = @("*.mp3", "*.wav", "*.flac", "*.m4a")
    )

    # Get the current directory
    $currentDir = Get-Location

    # Find audio files in the current folder and subfolders
    $audioFiles = Get-ChildItem -Path $currentDir -Recurse -Include $Extensions | Sort-Object Name

    # Check if any audio files were found
    if ($audioFiles.Count -eq 0) {
        Write-Output "No audio files found in the current folder or its subfolders."
        return
    }

    # Create the playlist file
    $playlistPath = Join-Path $currentDir $PlaylistName
    $audioFiles.FullName | Set-Content -Path $playlistPath

    Write-Output "Playlist created: $playlistPath"
}

cd E:\Music\
spotdl sync https://music.youtube.com/browse/VLPLg3vjVhK1vnYQWB26nwADGqEf2xHzgSZR --save-file data.spotdl  --audio youtube-music --bitrate auto --sponsor-block
Create-MusicPlaylist
cd -

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
