#!/bin/sh
set -x
set -o errexit
# PROCESSOR_COUNT=4

if [ -d "libevent-stable" ]; then
  rm -rf libevent-stable
fi

if [ ! -d "libevent-2.0.22-stable" ]; then
  wget -O - https://cdn01.moecube.com/ygopro-build-materials/libevent-2.0.22-stable.tar.gz | tar zfx -
fi

install_path="$PWD/libevent-stable"

cd libevent-2.0.22-stable
./configure "--prefix=$install_path" --disable-openssl --enable-static=yes --enable-shared=no "$@"
make -j$(nproc)
make install
cd ..
