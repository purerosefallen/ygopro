#!/bin/bash
set -x
set -o errexit

ARCHIVE_FILES=(ygopro.exe vcomp140.dll LICENSE README.md lflist.conf strings.conf system.conf servers.conf cards.cdb script textures deck single pics replay sound bot.conf Bot.exe WindBot locales fonts skin pack)

if [[ "$TARGET_LOCALE" == "zh-CN" && "$ARCHIVE_SUFFIX" != "zst" ]]; then
	ARCHIVE_FILES=("${ARCHIVE_FILES[@]}" update-koishipro)
fi

# TARGET_LOCALE
# ARCHIVE_SUFFIX
if [[ -z "$TARGET_PLATFORM" ]]; then
    TARGET_PLATFORM=win32
fi

apt update && apt -y install tar git zstd
mkdir dist replay

tar -acf "dist/KoishiPro-$CI_COMMIT_REF_NAME-$TARGET_PLATFORM-$TARGET_LOCALE.tar.$ARCHIVE_SUFFIX" --exclude='.git*' "${ARCHIVE_FILES[@]}"
