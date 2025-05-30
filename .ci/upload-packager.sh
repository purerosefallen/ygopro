#!/bin/bash
set -o errexit

apt update; apt -y install curl jq

apiRoot=https://api.moecube.com

loginInfo=$(curl -sL -X POST $apiRoot/accounts/signin -d account=$MYCARD_USERNAME -d password=$MYCARD_PASSWORD)
token=$(echo $loginInfo | jq '.token' | sed 's/"//g')
header="Authorization: $token"
echo "Login succeeded."

appName="koishipro"

handleErrorMessage() {
  rawJsonInput="$1"
  successInfo=$(echo "$rawJsonInput" | jq '.success')
  
  if [[ "$successInfo" != "true" ]]; then
    echo "$rawJsonInput"
    exit 1
  fi
}

runForDepot() {
  platform=$1
  locale=$2
  archivePath="./dist/KoishiPro-dlc-$appVersion-$platform-$locale.tar.zst"
  suffix="?platform=$platform&locale=$locale&arch=generic"
  echo "Uploading $archivePath"
  result=$(curl -H "$header" -X POST "$apiRoot/release/api/build/$appName/${appVersion}${suffix}" -F file=@$archivePath)
  handleErrorMessage "$result"
  echo "$result" | jq .
}

source .ci/asset-branch

if [[ "$ASSET_BRANCH_NAME" == "develop" ]]; then
  echo "This is a pre-release, skipping upload."
else
  runForDepot win32 zh-CN
  runForDepot linux zh-CN
  runForDepot darwin zh-CN
  runForDepot win32 en-US
  runForDepot linux en-US
  runForDepot darwin en-US
fi
