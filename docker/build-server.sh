#!/usr/bin/env bash

set -e

: ${APP_PATH:?}
: ${PUBLIC:?}
: ${APP_BUILD_PATH:?}
: ${APP_SERVER:?}
: ${PORT:?}
: ${SCRIPTS_PATH:?}
: ${ROOT_URL:?}

mkdir -p /tmp/app
mkdir -p /tmp/appbuild

cd /tmp/app
cp -rd ${APP_PATH}/* ./
rm -rf ./public || echo "Cannot delete public folder"
mkdir ./public
cp -r ${PUBLIC}/* ./public/ || echo "Public content copy failed."

echo "This is how app directory looks like..."
ls 
ls ./public/

cd /tmp/app
meteor create . || echo "App alreaday created"
meteor add-platform android || echo "Android already added"
bash ${SCRIPTS_PATH}/meteor_setup.sh
meteor build --architecture os.linux.x86_64 --server-only --directory /tmp/appbuild --mobile-settings mobile-config.js

cd /tmp/appbuild/bundle/programs/server
npm install --production

cd /tmp/appbuild/bundle
MONGO_URL=mongodb://localhost:27017/quranerkotha node main.js
