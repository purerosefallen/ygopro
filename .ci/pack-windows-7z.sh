#!/bin/bash
set -x
set -o errexit

ARCHIVE_FILES=(ygopro.exe vcomp140.dll LICENSE README.md lflist.conf strings.conf system.conf servers.conf cards.cdb script textures deck single pics replay sound bot.conf Bot.exe WindBot locales fonts skin pack)

if [[ "$TARGET_LOCALE" == "zh-CN" ]]; then
	ARCHIVE_FILES=("${ARCHIVE_FILES[@]}" update-koishipro)
fi

# TARGET_LOCALE
if [[ -z "$TARGET_PLATFORM" ]]; then
    TARGET_PLATFORM=win32
fi

apt update && apt -y install p7zip-full git
mkdir dist replay

7z a -mx9 -xr!.git* dist/KoishiPro-$CI_COMMIT_REF_NAME-win32-$TARGET_LOCALE.7z "${ARCHIVE_FILES[@]}"
