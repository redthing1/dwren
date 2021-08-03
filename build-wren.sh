#!/usr/bin/env bash

# adapted from https://raw.githubusercontent.com/zyedidia/termbox-d/master/build-termbox.sh

DIR=$(dirname "$0")
cd "$DIR"
if [ ! -f libwren.a ] || [ "$1" == "-f" ]; then
    echo "Building C Library"
    git clone https://github.com/wren-lang/wren.git wren040
    cd wren040
    git checkout 0.4.0
    pushd .
    cd projects/make
    make -j8
    popd    
    pwd
    cp lib/libwren.a ../libwren.a
    cd ..
    rm -rf wren040
fi