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
RUN apt-get autoclean && apt-get autoremove 

# Gradle version
ENV GRADLE_VERSION 4.1
ENV GRADLE_HOME /usr/local/gradle-${GRADLE_VERSION}
ENV PATH $PATH:${GRADLE_HOME}/bin

# Node version
ENV NODE_VERSION 10.x


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

# Initialize the build folder
RUN mkdir -p $APP_BUILD_PATH

# initialize public folder
RUN mkdir -p $PUBLIC

# Set build script as default executable

RUN useradd -ms /bin/bash newuser

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
RUN bash $SCRIPTS_PATH/meteor_setup.sh
RUN mkdir -p /tmp/appbuild && meteor build --directory /tmp/appbuild --architecture os.linux.x86_64 --server-only
RUN rm -rf /tmp/appbuild
RUN rm -rf /tmp/myapp

# Expose volumes
VOLUME $APP_BUILD_PATH
VOLUME $APP_PATH
VOLUME $PUBLIC

USER root
WORKDIR /usr/local/bin
COPY ./build-server.sh ./

RUN chmod +x ./*.sh

USER newuser
WORKDIR /usr/local/bin