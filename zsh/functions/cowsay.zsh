export COWPATH="$HOME/dotfiles/cows"

function cowsayRandom() {
  if hash lolcat 2>/dev/null; then
    cowsay -f "$(\ls ~/dotfiles/cows/*.cow | sort -R | head -1)" $1 | lolcat -t
  else
    cowsay -f "$(\ls ~/dotfiles/cows/ | sort -R | head -1)" $1
  fi
}

function cowsayPwd() {
  if hash cowsay 2>/dev/null; then
    cowsayRandom "you in $(pwd)"
  else
    echo "\033[0;32m❯\033[0m you in $(pwd)"
  fi
}

function cowsayGitStatus() {
  if hash cowsay 2>/dev/null; then
    cowsayRandom "git status"
  else
    echo "\033[0;32m❯\033[0m git status"
  fi
}
