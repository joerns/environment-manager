#!/bin/bash

# Source this file in your .bashrc

# Setup an alias to this script file
SCRIPTFILE=$(dirname "$(readlink -f "$BASH_SOURCE")")/envman.bash
alias envman=$SCRIPTFILE

function _mycomplete_()
{
    local cmd="${1##*/}"
    local word=${COMP_WORDS[COMP_CWORD]}
    local line=${COMP_LINE}
    local xpat

    # Check to see what command is being executed.
    case "$cmd" in
    envman)
        # See if we are fooing or unfooing.
        case "$line" in
        *go*)
            COMPREPLY=(`find $ENVMAN_BASEDIR/envs -path "${word}*.sh" -printf "%P\n"| while read NAME ; do echo ${NAME%.sh}; done`)
            ;;
        *edit*)
            COMPREPLY=(`find $ENVMAN_BASEDIR/envs $ENVMAN_BASEDIR/include -path "${word}*.sh" -printf "%P\n"| while read NAME ; do echo ${NAME%.sh}; done`)
            ;;
        esac
        ;;
    esac


}

complete  -F _mycomplete_ envman

