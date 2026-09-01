#!/bin/bash
set -x
set -o errexit

source .ci/prepare-repo
prepare_repo "https://code.moenext.com/nanahira/irrlicht-1.9.git" "irrlicht"
