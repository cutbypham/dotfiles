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
yt-dlp --cookies-from-browser firefox --download-archive archive.txt --extract-audio --audio-format mp3 --embed-thumbnail --embed-metadata --add-metadata -o "%(title)s.%(ext)s" "https://music.youtube.com/playlist?list=PLg3vjVhK1vnYQWB26nwADGqEf2xHzgSZR"
    cd -

cd C:\Users\master\repos\cutbypham\obs-studio\
auto-git-commit

cp $profile ~\repos\cutbypham\dotfiles\
cp C:\Users\master\AppData\Local\nvim\init.lua ~\repos\cutbypham\dotfiles\nvim
cp C:\Users\master\.gitconfig ~\repos\cutbypham\dotfiles\
cp C:\Users\master\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json ~\repos\cutbypham\dotfiles\windows-terminal\
cp C:\Users\master\AppData\Roaming\Mozilla\Firefox\Profiles\3wr0grx7.default-release\user.js ~\repos\cutbypham\dotfiles\

cd C:\Users\master\repos\cutbypham\dotfiles
auto-git-commit
