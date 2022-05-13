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
echo Writing to $ofile:
echo "[user]" | tee -a $ofile
echo "	name = $name" | tee -a $ofile
echo "	email = $email" | tee -a $ofile
echo "[include]" | tee -a $ofile
echo "	path = $relpath/all" | tee -a $ofile
unames=$(uname -s)
if [[ ${unames} =~ ^Darwin ]]; then platform=macos
elif [[ $TERM = cygwin ]]; then platform=gitbash
elif [[ ${unames} =~ ^MINGW ]]; then platform=gitbash
elif [[ ${unames} =~ ^MSYS ]]; then platform=gitbash
elif env | grep ^WSL_ >/dev/null; then platform=wsl
else platform=linux
fi
echo "	path = $relpath/$platform" | tee -a $ofile
echo "	path = $relpath/local" | tee -a $ofile
echo "[alias]" | tee -a $ofile
echo "	configpath = !echo $path" | tee -a $ofile
