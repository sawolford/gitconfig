#!/bin/bash
if [ $# -ne 2 ]; then
    echo Usage: $0 \"name\" \"email\"
    exit 1
fi
name=$1
email=$2
path=$(pwd)
relpath=${path/${HOME}\//}
ofile=${HOME}/.gitconfig
[ -e $ofile ] && mv -f $ofile $ofile.bak
unames=$(uname -s)
if [[ ${unames} =~ ^Darwin ]]; then platform=macos
elif [[ $TERM = cygwin ]]; then platform=gitbash
elif [[ ${unames} =~ ^MINGW ]]; then platform=gitbash
elif [[ ${unames} =~ ^MSYS ]]; then platform=gitbash
elif env | grep ^WSL_ >/dev/null; then platform=wsl
else platform=linux
fi
echo "<<<<$ofile>>>>"
tee $ofile <<EOF
[user]
    name = $name
    email = $email
[include]
    path = $relpath/platform/$platform
    path = $relpath/config/standard
    path = $relpath/include
[alias]
    configpath = !echo $path
EOF
ofile=include
echo "<<<<$ofile>>>>"
tee $ofile <<EOF
[include]
#    path = alias/argv       # a* aliases plus helpers
#    path = alias/attributes # manage file types and permissions
    path = alias/backup     # tar source and .git folders
    path = alias/branch     # checkout branches based on rules
#    path = alias/clang      # clang-format and clang-tidy
    path = alias/diff       # diff and difftool
    path = alias/empty      # manage empty commits
#    path = alias/gitlab     # gitlab restful api calls
    path = alias/gitlog     # git log aliases
#    path = alias/gpg        # experimental gpg aliases
    path = alias/helper     # used by many other aliases
    path = alias/merge      # merge and rebase aliases
#    path = alias/move       # move branches around
#    path = alias/parents    # examine changeset parents
    path = alias/output     # fancy output
#    path = alias/shallow    # convert between deep and shallow clones
    path = alias/squash     # combine commits
    path = alias/stow       # alternative stash
    path = alias/submodule  # manage submodules better
#    path = alias/version    # global version number from submodules
    path = local/local      # local configuration
    path = local/schemes    # url rewrites
EOF
