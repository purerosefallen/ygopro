#!/bin/bash
set -x
set -o errexit
# TARGET_LOCALE

apt update && apt -y install tar git
git submodule update --init
mkdir dist replay
tar -zcf dist/KoishiPro-$CI_COMMIT_REF_NAME-linux-$TARGET_LOCALE.tar.gz --exclude='.git*' ygopro LICENSE README.md lib lflist.conf strings.conf system.conf cards.cdb script textures deck single pics replay sound windbot bot bot.conf locales fonts
