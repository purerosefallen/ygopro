#!/bin/bash
set -x
set -o errexit

ARCHIVE_FILES=(ygopro.exe vcomp140.dll cards.cdb locales fonts sound textures strings.conf system.conf servers.conf skin pack)

if [[ -z "$TARGET_PLATFORM" ]]; then
    TARGET_PLATFORM=win32
fi

apt update && apt -y install tar zstd
mkdir dist replay

cp -rf locales/$TARGET_LOCALE/* .

tar -acf "dist/KoishiPro-dlc-$CI_COMMIT_REF_NAME-$TARGET_PLATFORM-$TARGET_LOCALE.tar.$ARCHIVE_SUFFIX" --exclude='.git*' "${ARCHIVE_FILES[@]}"
