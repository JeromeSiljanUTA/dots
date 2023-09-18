[[ $- != *i* ]] && return

neofetch

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

alias ls='ls --color=auto'

alias au='arduino-cli compile --fqbn esp8266:esp8266:nodemcuv2 && arduino-cli upload -p /dev/ttyUSB0 --fqbn esp8266:esp8266:nodemcuv2'
alias am='stty -F /dev/ttyUSB0 raw 115200 && cat /dev/ttyUSB0'
alias aum='au && am'

alias n='clear && neofetch'
alias N='cd && clear && neofetch'

alias B='vim ~/notes/books/Bible/Daily\ Log.md'
alias Q='vim ~/notes/QuickNote.md'
alias gl='git log --oneline'

alias graph='python ~/misc/projects/python/Bible\ graph/Bible_graph.py'

alias pls='sudo $(history -p !!)'

alias zathura='zathura --fork'
alias sqlite3='sqlite3 -column'
alias bc='bc -l'

alias mpvf='mpv "$(find /home/jerome -not -path "*/.*" -type d | fzf)"'
alias vid='mpv "$(find /home/jerome/media/video -type d -not -path "*/.*"| fzf)"'

alias zf='zathura --fork "$(locate "*.pdf" | fzf)"'
alias vf='vim "$(locate "*.pdf")"'
alias cf='cd "$(find ~/ -type d | fzf)"'

alias tmux='tmux -f ~/.config/tmux/tmux.conf'
alias wget='wget --hsts-file=~/.config/wget-hsts'
alias dd='dd status=progress'

alias dis='~/misc/linux/gentoo/kill_discord.sh'

alias ch='~/.config/bspwm/notif/changer.sh && n'

alias record='ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 output.mp4'

alias lofi='mpv https://www.youtube.com/watch?v=jfKfPfyJRdk --no-resume-playback'

alias python='python3'

alias ptt='putty -load default'

alias cnf='command-not-found'

alias cppng='xclip -selection clipboard -t image/png -o > '
alias cpjpg='xclip -selection clipboard -t image/jpg -o > '
alias cpjpeg='xclip -selection clipboard -t image/jpeg -o > '

alias pdb='python -m pdb'

alias cc='cz c'
alias wol='wol 38:63:bb:3b:32:78'

export PATH="$PATH:/home/jerome/.local/bin"
source "/home/jerome/.pam_environment"

export IDF_PATH=~/esp/ESP8266_RTOS_SDK/

eval "$(direnv hook bash)"
