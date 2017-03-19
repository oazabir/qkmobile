# কু’রআনের কথা Quraner Kotha mobile app version
Mobile app to read Quranerkotha.com website offline without internet connection.

# Features
 - Offline content from quranerkotha.com website. 
 - Push notification to notify about new articles. 
 - App updates itself using latest code pushed on server, using hot code push feature. 
 - Remembers last article. 

# Getting started

Install meteor.

Clone the repository.

Run ```meteor npm install``` inside quranerkotha.app folder. 

Create a symbolic link to map ./quranetkotha.app/public to ./quranerkotha.com folder. 

```
quranerkotha.app$ ln -s ../quranerkotha.com public
```

Go inside quranerkotha.app

Run the app using ```meteor run```. This will start a server at localhost:3000 and you can browse it on browser. 

To run on Android device: ```meteor run android-device```

To run using the app.quranerkotha.com server: ```meteor run android-device --mobile-server https://app.quranerkotha.com/```


NOTE: Does not work on Windows. File paths are more than 240 characters inside cordova folders and meteor build breaks. You can run locally though and do local development. But build will fail. 

# Fixing Android SDK issues

There's some issue with Meteor version and Android SDK incompatibility. Here's what to do:

Install latest Android SDK. 

Then download the Android Tools 25.2.x. It has to be the 25.2.x version. Latest versions do not work.

Then copy everything in the tools zip/tar into the SDK's tools folder. You will see there are some new files that come up, which weren't there in the SDK's tools folder. 

Only after this, meteor run/build for android device will work. 
