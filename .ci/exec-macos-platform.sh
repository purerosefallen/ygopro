#!/bin/bash
set -x
set -o errexit

TARGET_YGOPRO_BINARY_PATH=./ygopro-platforms/ygopro-platform-$TARGET_ARCH
export YGOPRO_LIBEVENT_STATIC_PATH=$PWD/libevent-stable

git submodule update --init

./premake5 gmake --cc=clang
cd build
make config=release -j4
cd ..

mkdir ygopro-platforms
mv bin/release/ygopro.app $TARGET_YGOPRO_BINARY_PATH

install_name_tool -change /usr/local/lib/libirrklang.dylib @executable_path/../Frameworks/libirrklang.dylib $TARGET_YGOPRO_BINARY_PATH
strip $TARGET_YGOPRO_BINARY_PATH
