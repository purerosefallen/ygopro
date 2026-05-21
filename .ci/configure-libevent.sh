#!/bin/sh
set -x
set -o errexit

SCRIPT_DIR="$(CDPATH= cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(CDPATH= cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_DIR/event"
chmod +x configure build-aux/* || true

if [ -n "${NDK_DIR:-}" ]; then
    ANDROID_API_LEVEL="${ANDROID_API_LEVEL:-26}"
    case "$NDK_DIR" in
        /*)
            NDK_DIR_PATH="$NDK_DIR"
            ;;
        *)
            NDK_DIR_PATH="$PROJECT_DIR/$NDK_DIR"
            ;;
    esac
    NDK_DIR_ABS="$(cd "$NDK_DIR_PATH" && pwd)"
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
