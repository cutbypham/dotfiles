function play_music
  set -l current_dir (pwd)
  cd ~/Music/
  set -l playlist (fd --hidden --type directory . | fzf_down --preview 'echo {} | tr -d \'()\' | awk \'{printf "%s ",  $2} {print  $1}\' | xargs -r exa --tree --icons')
  cd $playlist
  mpv --loop-playlist --shuffle *
  cd $current_dir
end