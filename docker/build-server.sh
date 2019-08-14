#!/usr/bin/env bash

set -e

: ${APP_PATH:?}
: ${APP_BUILD_PATH:?}
: ${APP_SERVER:?}

mkdir -p /tmp/app
mkdir -p /tmp/appbuild

cp -r ${APP_PATH}/. /tmp/app/

cd /tmp/app
bash meteor_setup.sh
meteor npm install --production
meteor build --directory /tmp/appbuild --architecture os.linux.x86_64 --server-only

cd /tmp/appbuild/bundle/programs/server
npm install --production

cd /tmp/appbuild/bundle
MONGO_URL=mongodb://localhost:27017/quranerkotha ROOT_URL=${APP_SERVER} node main.js