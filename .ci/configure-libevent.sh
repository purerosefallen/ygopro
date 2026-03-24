#!/bin/sh
set -x
set -o errexit

cd event

if [ -n "${NDK_DIR:-}" ]; then
    ANDROID_API_LEVEL="${ANDROID_API_LEVEL:-26}"
    NDK_DIR_ABS="$(cd "$NDK_DIR" && pwd)"
    NDK_PREBUILT_DIR="$(find "$NDK_DIR_ABS/toolchains/llvm/prebuilt" -mindepth 1 -maxdepth 1 -type d | sort | head -n 1)"
    if [ -z "$NDK_PREBUILT_DIR" ]; then
        echo "Android NDK toolchain not found under $NDK_DIR_ABS/toolchains/llvm/prebuilt" >&2
        exit 1
    fi
    NDK_BIN_DIR="$NDK_PREBUILT_DIR/bin"
    export CC="$NDK_BIN_DIR/clang --target=aarch64-linux-android$ANDROID_API_LEVEL"
    export CXX="$NDK_BIN_DIR/clang++ --target=aarch64-linux-android$ANDROID_API_LEVEL"
    export AR="$NDK_BIN_DIR/llvm-ar"
    export RANLIB="$NDK_BIN_DIR/llvm-ranlib"
    ./configure \
        --host=aarch64-linux-android \
        --disable-openssl \
        --enable-static=yes \
        --enable-shared=no
else
    ./configure --disable-openssl --enable-static=yes --enable-shared=no
fi

sed -f make-event-config.sed < config.h > ./include/event2/event-config.h
cd ..
