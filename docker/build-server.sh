#!/usr/bin/env bash

set -e

: ${APP_PATH:?}
: ${PUBLIC:?}
: ${APP_BUILD_PATH:?}
: ${APP_SERVER:?}
: ${PORT:?}

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
bash meteor_setup.sh
meteor npm install --production
meteor build --directory /tmp/appbuild --architecture os.linux.x86_64 --server-only

cd /tmp/appbuild/bundle/programs/server
npm install --production

cd /tmp/appbuild/bundle
MONGO_URL=mongodb://localhost:27017/quranerkotha ROOT_URL=${APP_SERVER} PORT=${PORT} node main.js
