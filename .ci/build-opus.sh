#!/bin/sh
set -x
set -o errexit

cd miniaudio

external_built_dir="$PWD/external-built"

is_macos=false
if [ "$(uname)" = "Darwin" ]; then
  is_macos=true
fi

maybe_patch_configure_output() {
  if $is_macos; then
    sed -i.bak 's/-force_cpusubtype_ALL//g' Makefile
  fi
}

build_single_thing() {
  lib_name="$1"
  cd "external/$lib_name"
  shift
  PKG_CONFIG_PATH="$external_built_dir/lib/pkgconfig" ./configure --prefix="$external_built_dir" --enable-static=yes --enable-shared=no "$@"
  maybe_patch_configure_output
  make -j$(nproc)
  make install
  cd ../..
}

build_single_thing ogg
build_single_thing opus
build_single_thing opusfile --disable-examples --disable-http
build_single_thing vorbis --with-ogg="$external_built_dir"

cd ..
