#!/bin/bash
set -x
set -o errexit

ARCHIVE_FILES=(ygopro.exe LICENSE README.md lflist.conf strings.conf system.conf cards.cdb script textures deck single pics replay sound bot.conf Bot.exe WindBot locales fonts)

if [[ "$TARGET_LOCALE" == "zh-CN" && "$ARCHIVE_SUFFIX" != "zst" ]]; then
	ARCHIVE_FILES=("${ARCHIVE_FILES[@]}" update-koishipro)
fi

# TARGET_LOCALE
# ARCHIVE_SUFFIX
TARGET_PLATFORM=win32

apt update && apt -y install tar git zstd
git submodule update --init
mkdir dist replay

tar -acf "dist/KoishiPro-$CI_COMMIT_REF_NAME-$TARGET_PLATFORM-$TARGET_LOCALE.tar.$ARCHIVE_SUFFIX" --exclude='.git*' "${ARCHIVE_FILES[@]}"
