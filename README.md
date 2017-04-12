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

Go inside app directory.

Run ```meteor create .```

Run ```meteor npm install``` inside quranerkotha.app folder. 

Create a symbolic link to ../quranerkotha.com folder to a directory ```public```. If it already exists, remove it first. 

```ln -s ../quranerkotha.com public```

Add android platform. See next section for configuring Android SDK. You need to take some special steps to configure Android SDK with the right set of tools for meteor to work. The standard Android Studio installation or SDK installation does not work for meteor. 

```meteor add-platform android```

Then add the plugins:

```
metoer add cordova:onesignal-cordova-plugin@2.0.11
```

To run on Android device: ```meteor run android-device```

To run using the app.quranerkotha.com server: ```meteor run android-device --mobile-server https://app.quranerkotha.com/```


NOTE: Does not work on Windows. File paths are more than 240 characters inside cordova folders and meteor build breaks. You can run locally though and do local development. But build will fail. 

# Configure Android SDK

This requires some special steps to install Android SDK via command line. 

First download the command line tools. 

https://developer.android.com/studio/index.html#command-tools

Create a folder named 'android-sdk'. Then inside that, extract the zip so that you get a tools folder inside it.


Then run this from android-sdk/tools folder:

```
./android update sdk --no-list sdk --all
```

From the list, find the number for these:

 - 1- Android SDK Tools, revision 25.2.5
 - 2- Android SDK Platform-tools, revision 25.0.4
 - 5- Android SDK Build-tools, revision 25.0.2
 - 36- SDK Platform Android 7.0, API 24, revision 2
 - 164- Android Support Repository, revision 47
 - 171- Google Repository, revision 46
 - 164- Android Support Repository, revision 47
 
Assuming you have seen the above numbers. Then run this command to install them:

```
./android update sdk --no-ui --filter 1,2,5,36,164,171
```

If the numbers were different for you, then make sure you use the correct numbers. 

After this, you will most likely see the tools folder is empty or just have couple of folders. All the files you extracted from the SDK tools are gone. So, you need to extract the zip again, and bring back all the files. 

