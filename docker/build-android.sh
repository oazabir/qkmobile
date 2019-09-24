#!/usr/bin/env bash

set -e

: ${APP_PATH:?}
: ${APP_BUILD_PATH:?}
: ${KEYSTORE_FILE_PATH:?}
: ${KEYSTORE_ALIAS:?}
: ${ANDROID_HOME:?}
: ${SCRIPTS_PATH:?}
: ${SERVER_URL:?}

APK_FILE_NAME=${APK_FILE_NAME-"release-signed.apk"}
TMP_APP_PATH=/tmp/app
TMP_BUILD_PATH=/tmp/build

echo "Meteor version (make sure it matches with server)"
meteor --version

echo "Launching mobile build..."

mkdir -p ${TMP_APP_PATH}
mkdir -p ${TMP_BUILD_PATH}

cd ${TMP_APP_PATH}

cp -rd ${APP_PATH}/* ./
rm -rf ./public || echo "Cannot delete public folder"
mkdir ./public
cp -r ${PUBLIC}/* ./public/ || echo "Public content copy failed."

echo "This is how app directory looks like..."
ls -la
ls -la ./public/

echo "Add meteor libraries..."
meteor create . || echo "Already created"
meteor add-platform android || echo "Already Android"
bash ${SCRIPTS_PATH}/meteor_setup.sh

echo "Building Meteor app..."
([[ -f mobile-config.js ]] && echo "mobile-config.js found") || (echo "mobile-config.js missing" && exit 1)
meteor build --directory ${TMP_BUILD_PATH} --server ${SERVER_URL} 

cd ${TMP_BUILD_PATH}

echo "Signing and preparing APK for release..."

APK_UNSIGNED_FILE_NAME=$(find ${TMP_BUILD_PATH} -name *.apk | grep "/release/" | head -n 1)
    
echo "Found APK at ${APK_UNSIGNED_FILE_NAME}"
# mv ${APK_UNSIGNED_FILE_NAME} ./

CMD="jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
    -keystore ${KEYSTORE_FILE_PATH} ${APK_UNSIGNED_FILE_NAME} ${KEYSTORE_ALIAS}"

${CMD} || ${CMD} || "Failed jarsigner twice"

${ANDROID_HOME}/build-tools/*/zipalign 4 ${APK_UNSIGNED_FILE_NAME} ${APK_FILE_NAME}

mv ./${APK_FILE_NAME} ${APP_BUILD_PATH}

cd ${APP_BUILD_PATH}

rm -fr ${TMP_APP_PATH}
rm -fr ${TMP_BUILD_PATH}

echo "Done!"
