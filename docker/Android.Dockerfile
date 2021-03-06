FROM ubuntu:16.04

# App variables

ENV APP_PATH /app
ENV APP_BUILD_PATH /build
ENV SCRIPTS_PATH /scripts
ENV PUBLIC /app/public

# Install package dependencies

RUN apt-get update 
RUN apt-get install -y openjdk-8-jdk wget curl \
	build-essential chrpath libssl-dev libxft-dev libfreetype6 \
	libfreetype6-dev libfontconfig1 libfontconfig1-dev python git unzip
RUN apt-get install -y usbutils
RUN apt-get autoclean && apt-get autoremove 

# Android SDK variables

ENV ANDROID_SDK_URL https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
ENV ANDROID_SDK_PATH /android
ENV ANDROID_PLATFORM platforms;android-28
ENV ANDROID_BUILD_TOOLS build-tools;28.0.3
#ENV ANDROID_SDK_FILTER platform-tool,android-28,build-tools-28.0.3

# Gradle version
ENV GRADLE_VERSION 4.1
ENV GRADLE_HOME /usr/local/gradle-${GRADLE_VERSION}
ENV PATH $PATH:${GRADLE_HOME}/bin

# Node version
ENV NODE_VERSION 10.x

# Download and extract the Android SDK

RUN mkdir -p $ANDROID_SDK_PATH

WORKDIR $ANDROID_SDK_PATH

RUN wget $ANDROID_SDK_URL -O android-sdk.zip && \
	unzip android-sdk.zip -d android-sdk-linux && \
	rm -fr android-sdk.zip && \
	mkdir ~/.android/ && \
	touch ~/.android/repositories.cfg 

# Install the Android SDK
WORKDIR $ANDROID_SDK_PATH/android-sdk-linux

RUN yes | tools/bin/sdkmanager --licenses
RUN tools/bin/sdkmanager --update
RUN tools/bin/sdkmanager "${ANDROID_PLATFORM}"
RUN tools/bin/sdkmanager "platform-tools"
RUN tools/bin/sdkmanager "${ANDROID_BUILD_TOOLS}"
RUN tools/bin/sdkmanager "extras;android;m2repository"
RUN tools/bin/sdkmanager "extras;google;m2repository"

# Update Android SDK environment variables

ENV ANDROID_HOME $ANDROID_SDK_PATH/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools


# Copy scripts

RUN mkdir -p $SCRIPTS_PATH

WORKDIR $SCRIPTS_PATH

COPY ./install-node-meteor.sh ./
COPY ./tar-override.sh ./
COPY ./tar-restore.sh ./
COPY ./meteor_setup.sh ./

RUN chmod -R +x .

# Install Meteor and Node

WORKDIR $SCRIPTS_PATH

RUN bash ./install-node-meteor.sh

# Create default keystore (user should provide her own)
ENV KEYSTORE_FILE_PATH /app/.keystore

# Initialize the build folder
RUN mkdir -p $APP_BUILD_PATH

# initialize public folder
RUN mkdir -p $PUBLIC

# Set build script as default executable

RUN useradd -ms /bin/bash newuser

RUN chown newuser -R $ANDROID_SDK_PATH
RUN chown newuser -R $APP_BUILD_PATH
RUN chown newuser -R $APP_PATH
RUN chown newuser -R $SCRIPTS_PATH
RUN chown newuser -R $PUBLIC
RUN chown newuser -R ${GRADLE_HOME}


USER newuser
WORKDIR /tmp
# Create a test app to download meteor libraries
RUN meteor create --full myapp 

WORKDIR /tmp/myapp
RUN meteor add-platform android 
RUN bash $SCRIPTS_PATH/meteor_setup.sh
RUN mkdir -p /tmp/appbuild && meteor build --directory /tmp/appbuild --server http://localhost
RUN rm -rf /tmp/appbuild
RUN rm -rf /tmp/myapp

# Expose volumes
VOLUME $APP_BUILD_PATH
VOLUME $APP_PATH
VOLUME $PUBLIC

USER root
WORKDIR /usr/local/bin
COPY ./build-android.sh ./
RUN chmod +x ./*.sh

USER newuser
WORKDIR /usr/local/bin
