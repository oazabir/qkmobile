#!/usr/bin/env bash

set -e

: ${SCRIPTS_PATH:?}
: ${GRADLE_VERSION:?}
: ${NODE_VERSION:?}

echo "Installing Meteor..."

# Override tar with bsdtar as a temporal fix for:
# https://github.com/docker/hub-feedback/issues/727

bash ${SCRIPTS_PATH}/tar-override.sh
curl https://install.meteor.com/ | sh
bash ${SCRIPTS_PATH}/tar-restore.sh

echo "Installing Node..."

curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash -
apt-get install -y nodejs
npm install npm -g

echo 'Install gradle'

# Download and install Gradle
cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip && \
    rm gradle-${GRADLE_VERSION}-bin.zip

# Export some environment variables
export GRADLE_HOME=/usr/local/gradle-${GRADLE_VERSION}
export PATH=$PATH:$GRADLE_HOME/bin
