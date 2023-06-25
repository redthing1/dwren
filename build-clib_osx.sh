#!/usr/bin/env bash

###
### DEPENDENCY LIBRARY BUILDER SCRIPT
### redthing1
###

set -e

HOST="dwren"
LIB_NAME="wren"
SOURCETREE_URL="https://github.com/wren-lang/wren"
SOURCETREE_DIR="cwren_source"
SOURCETREE_BRANCH="main"
LIB_FILE_1="libwren.a"

PACKAGE_DIR=$(dirname "$0")
cd "$PACKAGE_DIR"
pushd .
if [ ! -f $LIB_FILE_1 ] || [ "$1" == "-f" ]; then
    echo "[$HOST] building $LIB_NAME library..."

    # delete $SOURCETREE_DIR to force re-fetch source
    if [ -d $SOURCETREE_DIR ] 
    then
        echo "[$HOST] source folder already exists, using it." 
    else
        echo "[$HOST] getting source to build $LIB_NAME" 
        # git clone $SOURCETREE_URL $SOURCETREE_DIR
        git clone --depth 1 --branch $SOURCETREE_BRANCH $SOURCETREE_URL $SOURCETREE_DIR
    fi

    cd $SOURCETREE_DIR
    # git checkout $SOURCETREE_BRANCH
    # git submodule update --init --recursive

    echo "[$HOST] starting build of $LIB_NAME" 
    #
    # START BUILD
    #
    # build the library
    pushd .
    cd projects/make.mac
    make -j
    popd
    #
    # END BUILD
    #

    echo "[$HOST] finished build of $LIB_NAME" 

    echo "[$HOST] copying $LIB_NAME binary ($LIB_FILE_1) to $PACKAGE_DIR"
    cp -v $(pwd)/lib/$LIB_FILE_1 $PACKAGE_DIR/$LIB_FILE_1
    popd
else
    # delete $LIB_FILE_1 to force rebuild
    echo "[$HOST] library $LIB_NAME already built."
fi
