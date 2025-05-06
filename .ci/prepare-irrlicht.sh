#!/bin/bash
set -x
set -o errexit

IRRLICHT_REPO_URL="https://code.moenext.com/mycard/irrlicht-new.git"
IRRLICHT_BRANCH_NAME="master"

# if $CI_COMMIT_REF_NAME includes develop or pre, then we use the develop branch
if [[ "$CI_COMMIT_REF_NAME" == *"develop"* || "$CI_COMMIT_REF_NAME" == *".pre"* ]]; then
  IRRLICHT_BRANCH_NAME="develop"
fi

if [ ! -d "irrlicht" ]; then
  git clone --depth=1 --branch "$IRRLICHT_BRANCH_NAME" "$IRRLICHT_REPO_URL" irrlicht
else
  cd irrlicht
  git fetch origin "$IRRLICHT_BRANCH_NAME"
  git checkout "$IRRLICHT_BRANCH_NAME"
  git reset --hard origin/"$IRRLICHT_BRANCH_NAME"
  cd ..
fi
