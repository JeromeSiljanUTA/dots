#
# ~/.bashrc
#

# If not running interactively, don't do anything


[[ $- != *i* ]] && return

paleofetch

alias ls='ls --color=auto'

alias au='arduino-cli compile --fqbn esp8266:esp8266:nodemcuv2 && arduino-cli upload -p /dev/ttyUSB0 --fqbn esp8266:esp8266:nodemcuv2'
alias am='stty -F /dev/ttyUSB0 raw 115200 && cat /dev/ttyUSB0'
alias aum='au && am'

alias n='clear && fastfetch'
alias N='cd && clear && fastfetch'

alias B='vim ~/notes/books/Bible/Daily\ Log.md'
alias Q='vim ~/notes/QuickNote.md'
alias gl='git log --oneline'

alias graph='python ~/misc/projects/python/Bible\ graph/Bible_graph.py'

alias pls='sudo $(history -p !!)'

alias zathura='zathura --fork'

alias sqlite3='sqlite3 -column'

alias bc='bc -l'

alias vf='vim "$(fzf)"'

alias mpvf='mpv "$(find /home/jerome -not -path "*/.*" -type d | fzf)"'

#alias zf='zathura --fork "$(find ~/ -not -path "*/.*" -type f -name "*.pdf" | fzf)"'
#alias ef='"$(find ~/ -not -path "*/.*" -type f -name "*.sh" | fzf)"'
#alias vf='vim "$(find ~/ -not -path "*/.*" -type f -name "*.*" | fzf)"'
#alias cf='cd "$(find . -not -path "*/.*" -type d | fzf)"'

alias zf='zathura --fork "$(find ~/ | grep -i ".pdf" | fzf)"'
alias ef='"$(find ~/ | grep -i ".pdf" | fzf)"'
alias vf='vim "$(find ~/ | fzf)"'
alias cf='cd "$(find ~/ | fzf)"'

alias ssh='ssh -F ~/.config/ssh/'
alias tmux='tmux -f ~/.config/tmux/tmux.conf'
alias wget='wget --hsts-file=~/.config/wget-hsts'
alias dd='dd status=progress'

alias dis='~/misc/linux/gentoo/kill_discord.sh'

alias youtube-dl='youtube-dl --write-auto-subs'

alias sus='N && sleep 2s && loginctl suspend'
alias hib='N && sleep 2s && loginctl hibernate'

#alias ch='~/.config/sway/wallpapers/changer.sh && n'
alias ch='~/.config/bspwm/notif/changer.sh && n'

alias record='ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 output.mp4'

alias ssh='kitty +kitten ssh'

alias moo='emerge --moo'

alias lofi='mpv https://www.youtube.com/watch?v=jfKfPfyJRdk --no-resume-playback'

alias activate='source venv/bin/activate'

#alias upd='update && n'
#alias U='update && N'
alias cf='cd "$(cat ~/.config/fzf/dir | fzf)"'
alias zf='zathura --fork "$(cat ~/.config/fzf/zath | fzf)"'

alias ptt='putty -load default'

alias cc='cz c'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$PATH:/home/jerome/.local/bin"
source "/home/jerome/.pam_environment"
#update & 
