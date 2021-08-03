#!/usr/bin/env bash

# adapted from https://raw.githubusercontent.com/zyedidia/termbox-d/master/build-termbox.sh

DIR=$(dirname "$0")
cd "$DIR"
if [ ! -f libsoundpipe.a ] || [ "$1" == "-f" ]; then
    echo "Building C Library"
    rm -rf soundpipe-master
    git clone https://github.com/xdrie/soundpipe.git soundpipe-master
    cd soundpipe-master
    make -j8
    pwd
    cp libsoundpipe.a ../libsoundpipe.a
    cd ..
    rm -rf soundpipe-master
fi