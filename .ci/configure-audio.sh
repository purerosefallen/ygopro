#!/bin/bash

libs_to_configure=(
  "ogg"
  # "opus"
)

cd miniaudio/external
for lib in "${libs_to_configure[@]}"; do
  cd $lib
  chmod +x configure || true
  ./configure
  cd ..
done
