#!/bin/bash
set -x
set -o errexit

ARCHIVE_FILES=(ygopro cards.cdb locales fonts sound textures strings.conf system.conf pack)

TARGET_PLATFORM=linux

apt update && apt -y install tar zstd
mkdir dist replay

cp -rf locales/$TARGET_LOCALE/* .

tar -acf "dist/KoishiPro-dlc-$CI_COMMIT_REF_NAME-$TARGET_PLATFORM-$TARGET_LOCALE.tar.$ARCHIVE_SUFFIX" --exclude='.git*' "${ARCHIVE_FILES[@]}"
