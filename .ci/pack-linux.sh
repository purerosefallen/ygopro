#!/bin/bash
set -x
set -o errexit

ARCHIVE_FILES=(ygopro LICENSE README.md lib lflist.conf strings.conf system.conf cards.cdb script textures deck single pics replay sound windbot bot bot.conf locales fonts)

# TARGET_LOCALE
# ARCHIVE_SUFFIX
TARGET_PLATFORM=linux

apt update && apt -y install tar git zstd
git submodule update --init
mkdir dist replay

tar -acf "dist/KoishiPro-$CI_COMMIT_REF_NAME-$TARGET_PLATFORM-$TARGET_LOCALE.tar.$ARCHIVE_SUFFIX" --exclude='.git*' "${ARCHIVE_FILES[@]}"
