#!/bin/bash
set -x
set -o errexit
# ygopro-database
apt update && apt -y install wget git p7zip-full
git clone --depth=1 https://code.mycard.moe/nanahira/ygopro-database
cp -rf ./ygopro-database/locales/$TARGET_LOCALE/* .
# ygopro-images
wget -O ygopro-images.zip  https://cdn01.moecube.com/images/ygopro-images-${TARGET_LOCALE}.zip
7z x -y -opics ygopro-images.zip
