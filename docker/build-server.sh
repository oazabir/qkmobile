#!/usr/bin/env bash

set -e

: ${APP_PATH:?}
: ${APP_BUILD_PATH:?}
: ${APP_SERVER:?}

cd ${APP_PATH}
meteor npm install --production
meteor build --directory ${APP_BUILD_PATH} --architecture os.linux.x86_64 --server-only

cd ${APP_BUILD_PATH}/bundle/programs/server
npm install --production

cd ${APP_BUILD_PATH}/bundle
MONGO_URL=mongodb://localhost:27017/quranerkotha ROOT_URL=${APP_SERVER} node main.js