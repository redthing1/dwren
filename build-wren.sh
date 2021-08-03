#!/usr/bin/env bash

# adapted from https://raw.githubusercontent.com/zyedidia/termbox-d/master/build-termbox.sh

DIR=$(dirname "$0")
cd "$DIR"
if [ ! -f libwren.a ] || [ "$1" == "-f" ]; then
    echo "Building C Library"
    cd wren040
    pushd .
    cd projects/make
    make -j8
    popd    
    pwd
    cp lib/libwren.a ../libwren.a
    cd ..
    rm -rf wren040
fi