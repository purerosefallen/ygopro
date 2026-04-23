#!/bin/sh
set -x
set -o errexit

cd event
chmod +x configure build-aux/* || true
./configure --disable-openssl --enable-static=yes --enable-shared=no
sed -f make-event-config.sed < config.h > ./include/event2/event-config.h
cd ..
