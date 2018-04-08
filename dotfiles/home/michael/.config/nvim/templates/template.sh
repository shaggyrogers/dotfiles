#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# %FILEHEADING%
# %FILEHEADINGULINE%
#
# Description:           %HERE%
# Author:                %USER% <%GITHUBUSER%>
# Creation Date:         %DATE%
# Modification Date:     %DATE%
# License:               %LICENSE%
#
###############################################################################

# Set shell options {{{
# Stop executing the script if an error occurs in a command or pipeline.
# Don't rely on this - there are a lot of special cases.
set -e
# Unassigned variables cause an error.
set -u
# If one command in a pipeline returns a nonzero error code, that error code is
# returned.
set -o pipefail
# }}}

# Help, usage, version info and other documentation {{{
# Version information {{{
# Given a version number MAJOR.MINOR.PATCH, increment the:
#    1. MAJOR version when you make incompatible API changes,
#    2. MINOR version when you add backwards-compatible functionality
#    3. PATCH version when you make backwards-compatible bug fixes.
# see https://semver.org/
 __version="$(cat <<- 'EOF'
   %FILEHEADING% 0.1.0
EOF
)" # }}}

# Usage information {{{
# Begin with 'Usage:'
# Show optional arguments with square brackets, using = for the default value
# Show required arguments with angled brackets
# Be as succinct and unambiguous as possible
# If appropriate, include examples for common use-cases
 __usage="$(cat <<- 'EOF'
   Usage: %FILEHEADING% [-h | --help] [--version] [-a | --option-a <argument>]
                        [-b | --option-b [argument]]
EOF
)" # }}}

# Help text {{{
__help="$(cat <<- 'EOF'
    Options
        --version               Display version information.

        -h, --help              Display this message.

        -a, --option-a <arg>
                                Test option with a mandatory argument.

        -b, --option-b [<arg>]
                                Test option with an optional argument. Avoid
                                using this. Must be used without whitespace
                                between the argument and option.

        Elaborate on options and their use here, if necessary.
EOF
)" # }}}

# version() : Diplay version info and exit {{{
version () {
    echo "" 1>&2
    echo "  ${__version:-No version information available}" 1>&2
    echo "" 1>&2

    exit 0
} # }}}

# help() : Diplay help info and exit {{{
help () {
    echo "" 1>&2
    echo "  ${__usage:-No usage available}" 1>&2
    echo "" 1>&2
    echo " ${__help}" 1>&2
    echo "" 1>&2

    exit 1
} # }}}
# }}}

# parse_arguments() : Set defaults and parse arguments {{{
parse_arguments() {
    # Source: /usr/share/doc/util-linux/examples/getopt-parse.bash
    TEMP=$(getopt -o 'ha:b::' -l 'help,version,option-a:,option-b::' \
        -n '%FILEHEADING%' -- "$@")

    if [ $? -ne 0 ]; then
        help
        exit 1
    fi

    eval set -- "$TEMP"
    unset TEMP

    # Set defaults {{{
    OPTION_A=0
    OPTION_B=0
    # }}}

    # Parse options {{{
    while true; do
        case "$1" in
            '-h'|'--help')
                help
                shift
                continue
            ;;
            '--version')
                version
                shift
                continue
            ;;
            # Required argument
            '-a'|'--option-a')
                OPTION_A="$2"
                shift 2
                continue
            ;;
            # Optional argument
            # Must be used like '-b0' or '--option-b0'
            '-b'|'--option-b')
                case "$2" in
                    '')
                        OPTION_B="1"
                    ;;
                    *)
                        OPTION_B="$2"
                    ;;
                esac
                shift 2
                continue
            ;;
            '--')
                shift
                break
            ;;
            *)
                echo 'Error: A valid argument was not parsed.' 1>&2
                exit 1
            ;;
        esac
    done
    # }}}

    ARGS_REMAINING="$@"
} # }}}

parse_arguments "$@"

exit 0

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
