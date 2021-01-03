# -*- coding: UTF-8 -*-
###############################################################################
# lscolors.plugin.zsh
# ===================
#
# Description:           Adds colors and aliases for some commands
# Author:                Michael De Pasquale
# Creation Date:         2018-03-04
# Modification Date:     2018-03-05
# License:               MIT
#
###############################################################################

# Color df {{{
function dfc () {
    if ! [ "$#" = '0' ]; then
        df "$@"
        return
    fi

    df -h \
        | awk '
            BEGIN {
                FPAT = "([[:space:]]*[^[:space:]]+)";
                OFS = "\t";
            }
            {
                $1 = "\033[31m" $1 "\033[0m";
                $2 = "\033[35m" $2 "\033[0m";
                $3 = "\033[34m" $3 "\033[0m";
                $4 = "\033[32m" $4 "\033[0m";
                $5 = "\033[33m" $5 "\033[0m";
                $6 = "\033[36m" $6
                print $0"\033[0m";
            }' \
        | column -s $'\t' -t
}

alias df='dfc'
# }}}

# Color lsblk {{{
lsblkc () {
    if ! [ "$#" = '0' ]; then
        lsblk "$@"
        return
    fi

    lsblk \
        | awk '
            BEGIN {
                FPAT = "([[:space:]]*[^[:space:]]+)";
                OFS = "\t";
            }
            {
                $1 = "\033[31m" $1 "\033[0m";
                $2 = "\033[35m" $2 "\033[0m";
                $3 = "\033[34m" $3 "\033[0m";
                $4 = "\033[32m" $4 "\033[0m";
                $5 = "\033[33m" $5 "\033[0m";
                $6 = "\033[36m" $6;
                print $0"\033[0m";
            }' \
        | column -s $'\t' -t
}

alias lsblk='lsblkc'
# }}}

# Color lsusb {{{
function lsusbc () {
    if ! [ "$#" = '0' ]; then
        lsusb "$@"
        return
    fi

    lsusb \
        | awk '
            BEGIN {
                FPAT = "([[:space:]]*[^[:space:]]+)";
                OFS = "";
            }
            {
                $1 = "\033[31m" $1;
                $2 =  $2 "\033[0m";
                $3 = "\033[34m" $3;
                $4 = $4 "\033[0m";
                $5 = "\033[33m" $5;
                $6 = $6 "\033[0m";
                $7 = "\033[36m" $7
                print $0"\033[0m";
            }' \
        | column -s $'\t' -t
}

alias lsusb='lsusbc'
# }}}

# color ls {{{
# Aliases {{{
# List, List All, Long List, Long List all 
# sort by name, (S)ize, e(X)tension, time (M)odified or use (V)ersion sort
# A space at the start prevents commands being saved in history

# Set default arguments
_LS_DEF_ARGS='--color=auto --escape --group-directories-first --human-readable \
        --indicator-style=slash --time-style=long-iso \
        --dereference-command-line'

alias l=" ls $_LS_DEF_ARGS"
alias ls=" ls $_LS_DEF_ARGS"
alias ll=" llsc --no-group $_LS_DEF_ARGS"
alias lla=" llsc -A --no-group $_LS_DEF_ARGS"
alias llam=" llsc -A --sort time --no-group $_LS_DEF_ARGS"
alias llas=" llsc -A --sort size--no-group $_LS_DEF_ARGS"
alias llax=" llsc -A --sort extension --no-group $_LS_DEF_ARGS"
alias llm=" llsc --sort time --no-group $_LS_DEF_ARGS"
alias lls=" llsc --sort size --no-group $_LS_DEF_ARGS"
alias llv=" llsc --sort version --no-group $_LS_DEF_ARGS"
alias llva=" llsc -A --sort version --no-group $_LS_DEF_ARGS"
alias llx=" llsc --sort extension --no-group $_LS_DEF_ARGS"
alias la=" ls -A $_LS_DEF_ARGS"
alias lsa=" ls -A $_LS_DEF_ARGS"
alias lsm=" ls --sort time $_LS_DEF_ARGS"
alias lsma=" ls -A --sort time $_LS_DEF_ARGS"
alias lss=" ls --sort size $_LS_DEF_ARGS"
alias lssa=" ls -A --sort size $_LS_DEF_ARGS"
alias lsv=" ls --sort version $_LS_DEF_ARGS"
alias lsva=" ls -A --sort version $_LS_DEF_ARGS"
alias lsx=" ls --sort extension $_LS_DEF_ARGS"
alias lsxa=" ls -A --sort extension $_LS_DEF_ARGS"
# }}}

# Colorise long-format ls columns {{{
# Taken from an answer by 'Bob':
# https://superuser.com/questions/1294743/how-to-color-output-columns-of-ls
# FIXME: Handle escaped spaces in filenames correctly
function llsc () {
    ls "$@" -l --color=always \
        | awk '
            BEGIN {
                FPAT = "([[:space:]]*[^[:space:]]+)";
                OFS = "\t";
            }
            {
                $1 = "\033[31m" $1 "\033[0m";
                $2 = "\033[35m" $2 "\033[0m";
                $3 = "\033[34m" $3 "\033[0m";
                $4 = "\033[32m" $4 "\033[0m";
                $5 = "\033[33m" $5 "\033[0m";
                $6 = "\033[33m" $6 "\033[0m";
                print $0
            }' \
        | column -s $'\t' -t
}
# }}}

# Configure ls colors {{{
# Attributes: 
#   00=none 01=bold 03=italic 04=underscore 05=blink 07=reverse 08=concealed
# Text Color: 
#   30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color:
#   40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
#   Background;Text;Attributes
# File types {{{
LS_COLORS=""
LS_COLORS+="rs=0:"
LS_COLORS+="di=01;34:"
LS_COLORS+="ln=01;36:"
LS_COLORS+="mh=00:"
LS_COLORS+="pi=40;33:"
LS_COLORS+="so=01;35:"
LS_COLORS+="do=01;35:"
LS_COLORS+="bd=40;33;01:"
LS_COLORS+="cd=40;33;01:"
LS_COLORS+="or=40;31;01:"
LS_COLORS+="mi=00:"
LS_COLORS+="su=37;41:"
LS_COLORS+="sg=30;43:"
LS_COLORS+="ca=30;41:"
LS_COLORS+="tw=30;42:"
LS_COLORS+="ow=30;42:"
LS_COLORS+="st=37;44:"
LS_COLORS+="ex=01;32:"
# }}}

# ls extension colors / styles{{{
# List any file extensions like '.gz' or '.tar' that you would like ls
# to colorize below. Put the extension, a space, and the color init string.
LS_COLORS+="*.tar=01;31:"
LS_COLORS+="*.tgz=01;31:"
LS_COLORS+="*.arc=01;31:"
LS_COLORS+="*.arj=01;31:"
LS_COLORS+="*.taz=01;31:"
LS_COLORS+="*.lha=01;31:"
LS_COLORS+="*.lz4=01;31:"
LS_COLORS+="*.lzh=01;31:"
LS_COLORS+="*.lzma=01;31:"
LS_COLORS+="*.tlz=01;31:"
LS_COLORS+="*.txz=01;31:"
LS_COLORS+="*.tzo=01;31:"
LS_COLORS+="*.t7z=01;31:"
LS_COLORS+="*.zip=01;31:"
LS_COLORS+="*.z=01;31:"
LS_COLORS+="*.Z=01;31:"
LS_COLORS+="*.dz=01;31:"
LS_COLORS+="*.gz=01;31:"
LS_COLORS+="*.lrz=01;31:"
LS_COLORS+="*.lz=01;31:"
LS_COLORS+="*.lzo=01;31:"
LS_COLORS+="*.xz=01;31:"
LS_COLORS+="*.zst=01;31:"
LS_COLORS+="*.tzst=01;31:"
LS_COLORS+="*.bz2=01;31:"
LS_COLORS+="*.bz=01;31:"
LS_COLORS+="*.tbz=01;31:"
LS_COLORS+="*.tbz2=01;31:"
LS_COLORS+="*.tz=01;31:"
LS_COLORS+="*.deb=01;31:"
LS_COLORS+="*.rpm=01;31:"
LS_COLORS+="*.jar=01;31:"
LS_COLORS+="*.war=01;31:"
LS_COLORS+="*.ear=01;31:"
LS_COLORS+="*.sar=01;31:"
LS_COLORS+="*.rar=01;31:"
LS_COLORS+="*.alz=01;31:"
LS_COLORS+="*.ace=01;31:"
LS_COLORS+="*.zoo=01;31:"
LS_COLORS+="*.cpio=01;31:"
LS_COLORS+="*.7z=01;31:"
LS_COLORS+="*.rz=01;31:"
LS_COLORS+="*.cab=01;31:"
LS_COLORS+="*.jpg=01;35:"
LS_COLORS+="*.jpeg=01;35:"
LS_COLORS+="*.mjpg=01;35:"
LS_COLORS+="*.mjpeg=01;35:"
LS_COLORS+="*.gif=01;35:"
LS_COLORS+="*.bmp=01;35:"
LS_COLORS+="*.pbm=01;35:"
LS_COLORS+="*.pgm=01;35:"
LS_COLORS+="*.ppm=01;35:"
LS_COLORS+="*.tga=01;35:"
LS_COLORS+="*.xbm=01;35:"
LS_COLORS+="*.xpm=01;35:"
LS_COLORS+="*.tif=01;35:"
LS_COLORS+="*.tiff=01;35:"
LS_COLORS+="*.png=01;35:"
LS_COLORS+="*.svg=01;35:"
LS_COLORS+="*.svgz=01;35:"
LS_COLORS+="*.mng=01;35:"
LS_COLORS+="*.pcx=01;35:"
LS_COLORS+="*.mov=01;35:"
LS_COLORS+="*.mpg=01;35:"
LS_COLORS+="*.mpeg=01;35:"
LS_COLORS+="*.m2v=01;35:"
LS_COLORS+="*.mkv=01;35:"
LS_COLORS+="*.webm=01;35:"
LS_COLORS+="*.ogm=01;35:"
LS_COLORS+="*.mp4=01;35:"
LS_COLORS+="*.m4v=01;35:"
LS_COLORS+="*.mp4v=01;35:"
LS_COLORS+="*.vob=01;35:"
LS_COLORS+="*.qt=01;35:"
LS_COLORS+="*.nuv=01;35:"
LS_COLORS+="*.wmv=01;35:"
LS_COLORS+="*.asf=01;35:"
LS_COLORS+="*.rm=01;35:"
LS_COLORS+="*.rmvb=01;35:"
LS_COLORS+="*.flc=01;35:"
LS_COLORS+="*.avi=01;35:"
LS_COLORS+="*.fli=01;35:"
LS_COLORS+="*.flv=01;35:"
LS_COLORS+="*.gl=01;35:"
LS_COLORS+="*.dl=01;35:"
LS_COLORS+="*.xcf=01;35:"
LS_COLORS+="*.xwd=01;35:"
LS_COLORS+="*.yuv=01;35:"
LS_COLORS+="*.cgm=01;35:"
LS_COLORS+="*.emf=01;35:"
LS_COLORS+="*.ogv=01;35:"
LS_COLORS+="*.ogx=01;35:"
LS_COLORS+="*.aac=00;36:"
LS_COLORS+="*.au=00;36:"
LS_COLORS+="*.flac=00;36:"
LS_COLORS+="*.m4a=00;36:"
LS_COLORS+="*.mid=00;36:"
LS_COLORS+="*.midi=00;36:"
LS_COLORS+="*.mka=00;36:"
LS_COLORS+="*.mp3=00;36:"
LS_COLORS+="*.mpc=00;36:"
LS_COLORS+="*.ogg=00;36:"
LS_COLORS+="*.ra=00;36:"
LS_COLORS+="*.wav=00;36:"
LS_COLORS+="*.oga=00;36:"
LS_COLORS+="*.opus=00;36:"
LS_COLORS+="*.spx=00;36:"
LS_COLORS+="*.xspf=00;36"
# }}}
# }}}
# }}}

#  vim: set ts=4 sw=4 tw=79 fdm=marker et : 
