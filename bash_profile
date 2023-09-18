#
# ~/.bash_profile
#

FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{.sword/*,.git/*,.cache/*,.local/*,.thunderbird/*,.cargo/*,.mozilla/*,.config/Signal/*,.pki/*,.gitconfig,.dmenu_cache,.wget-hsts,.lesshst,.vim/*,.arduino15/*}"'
QT_QPA_PLATFORMTHEME=gtk2
LESS_TERMCAP_mb=$'\e[1;32m'
LESS_TERMCAP_md=$'\e[1;32m'
LESS_TERMCAP_me=$'\e[0m'
LESS_TERMCAP_se=$'\e[0m'
LESS_TERMCAP_so=$'\e[01;33m'
LESS_TERMCAP_ue=$'\e[0m'
LESS_TERMCAP_us=$'\e[1;4;31m'
BC_ENV_ARGS=$HOME/.config/bcrc

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z $DISPLAY ] && [ "$(tty)" == "/dev/tty1" ];
then
    startx
fi






