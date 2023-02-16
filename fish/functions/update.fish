function update --description 'update all'
    set -l current_dir (pwd)

    pnpm add -g pnpm
    sudo dnf update -y
    dnf makecache
    deno upgrade
    tldr --update
    $HOME/.tmux/plugins/tpm/bin/update_plugins all

    cd $HOME/dotfiles/
    nvim --headless "+Lazy! sync" +qa
    git add nvim/lazy-lock.json
    git commit -m "chore: lazy.nvim"

    cd $current_dir
end