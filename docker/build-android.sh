#!/usr/bin/env bash

set -e

: ${APP_PATH:?}
: ${APP_BUILD_PATH:?}
: ${APP_SERVER:?}
: ${KEYSTORE_FILE_PATH:?}
: ${KEYSTORE_ALIAS:?}
: ${ANDROID_HOME:?}

APK_FILE_NAME=${APK_FILE_NAME-"release-signed.apk"}
TMP_APP_PATH=/tmp/app
TMP_BUILD_PATH=/tmp/build

echo "Launching mobile build..."

mkdir -p ${TMP_APP_PATH}
#mkdir -p ${TMP_APP_PATH}/public
mkdir -p ${TMP_BUILD_PATH}

cd ${TMP_APP_PATH}

cp -rp ${APP_PATH}/. ./
#cp -rp ${PUBLIC}/* ./public/

echo "This is how app directory looks like..."
ls 

echo "Add meteor libraries..."
meteor add-platform android || echo "Android is there"
meteor add ostrio:loggerconsole
meteor add ostrio:logger
meteor add themeteorchef:bert
meteor add cordova:onesignal-cordova-plugin@2.5.2
meteor add cordova:cordova-plugin-statusbar@2.4.3
meteor add cordova:cordova-plugin-splashscreen@5.0.3

#rm -fr ./node_modules && rm -fr ./.meteor/local
meteor npm install

echo "Building Meteor app..."

meteor build  --directory ${TMP_BUILD_PATH} --server ${APP_SERVER}

cd ${TMP_BUILD_PATH}

echo "Signing and preparing APK for release..."

APK_UNSIGNED_FILE_NAME=$(find ${TMP_BUILD_PATH} -name *.apk | grep "/release/" | head -n 1)

echo "Found APK at ${APK_UNSIGNED_FILE_NAME}"
# mv ${APK_UNSIGNED_FILE_NAME} ./

jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
    -keystore ${KEYSTORE_FILE_PATH} ${APK_UNSIGNED_FILE_NAME} ${KEYSTORE_ALIAS}

${ANDROID_HOME}/build-tools/*/zipalign 4 ${APK_UNSIGNED_FILE_NAME} ${APK_FILE_NAME}

mv ./${APK_FILE_NAME} ${APP_BUILD_PATH}

cd ${APP_BUILD_PATH}

rm -fr ${TMP_APP_PATH}
rm -fr ${TMP_BUILD_PATH}

echo "Done!"
