#!/bin/bash
set -x
set -o errexit

ARCHIVE_FILES=(ygopro.app LICENSE README.md lflist.conf strings.conf system.conf servers.conf cards.cdb script textures deck single pics replay sound windbot bot bot.conf locales fonts pack)

# TARGET_LOCALE
# ARCHIVE_SUFFIX
if [[ -z "$TARGET_PLATFORM" ]]; then
    TARGET_PLATFORM=darwin
fi

apt update && apt -y install tar git zstd
mkdir dist replay

tar -acf "dist/KoishiPro-$CI_COMMIT_REF_NAME-$TARGET_PLATFORM-$TARGET_LOCALE.tar.$ARCHIVE_SUFFIX" --exclude='.git*' "${ARCHIVE_FILES[@]}"
