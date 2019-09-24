# কু’রআনের কথা Quraner Kotha mobile app version
Mobile app to read Quranerkotha.com website offline without internet connection.

# Features
 - Offline content from quranerkotha.com website. 
 - Push notification to notify about new articles. 
 - App updates itself using latest code pushed on server, using hot code push feature. _[Note: this is currently broken. Trying to fix it.]_

# Getting started 

Note: I have given up on vagrant. Now you need a Mac. 

- Install meteor https://www.meteor.com/install
- Go to app folder and run ```setup_meteor.sh```
- Install docker.

If you want to develop for Android, then
- Install Android SDK eg ```brew install android-sdk```
- Install Android Platform tools and build tools

```
export ANDROID_PLATFORM=platforms;android-27
export ANDROID_BUILD_TOOLS=build-tools;27.0.3
yes | sdkmanager --licenses
sdkmanager --update
sdkmanager "${ANDROID_PLATFORM}"
sdkmanager "platform-tools"
sdkmanager "${ANDROID_BUILD_TOOLS}"
sdkmanager "extras;android;m2repository
sdkmanager "extras;google;m2repository"
```
- Now you can run ```app/run_device.sh``` after attaching a device to directly launch the app on your mobile device. Make sure you turn on USB Debugging on your mobile device. 

If you want to build iOS apps, sorry, no idea. 

# Building app

- ```docker``` folder contains scripts to build the app for both mobile and server. 
- ```build-app.sh``` will build the app bundle, sign, and prepare for Google Play Store. You will need the private key from me to publish it on Google Play Store. 
- ```build-server.sh``` will build the server side, that runs on a server and allows the content updates to be synced to the mobile apps. 


