# !/usr/bin/env zsh

alias st='git status -sb'
alias add='git add'
alias push="git push"
alias pull="git pull"
alias cm='git commit'
alias dv='git difftool'

isInGitRepo() { git rev-parse HEAD > /dev/null 2>&1 }

function co () {
    isInGitRepo || return
    git branch -a | fzf-down | xargs git checkout
}

function autoCommit () {
    isInGitRepo || return
    git add -A
    git commit -m "[👌Auto commit] $(curl -s whatthecommit.com/index.txt)"
}

function ok () {
    isInGitRepo || return
    st
    autoCommit
    push
}

function gc () {
    gitDir="$(basename "$1" .git)"
    gitDirResolved=${2:-$gitDir}
    git clone "$@" && cd "$gitDirResolved";
}

alias glok='cd ~/sync/ok ; pull ; cd -'
alias ghok='cd ~/sync/ok ; ok ; cd -'

alias glnote='cd ~/sync/note ;  pull ; cd -'
alias ghnote='cd ~/sync/note ; ok ; cd -'

alias glzet='cd ~/.local/share/zet/ ; ok ; cd -'

function ghzet () {
    cp -r ~/sync/note/zet_publish ~/.local/share/zet/
    cp ~/sync/note/README.md ~/.local/share/zet/
    cd ~/.local/share/zet/
    ok
    cd -
}

function yo () {
    git diff
    git add .
    cowsay "What is commmit message?"
    read commitMessage
    git commit -m $commitMessage
    git push
}