# Quraner Kotha mobile app version
Mobile app that serves Quranerkotha.com in offline mode. It detects new changes on the website and updates the local cache. Also supports push notification receiving from main QK site.

# Getting started

Install meteor.

Clone the repository.

Run ```meteor npm install``` inside quranerkotha.app folder. 

Create a symbolic link to map ./quranetkotha.app/public to ./quranerkotha.com folder. 

```
quranerkotha.app$ ln -s ../quranerkotha.com public
```

On Windows, go to command prompt using Administrator. Then use ```mklink /D public ..\quranerkotha.com``` inside the quranerkotha.app folder. 

Go inside quranerkotha.app

Run the app using ```meteor run```. This will start a server at localhost:3000 and you can browse it on browser. 

To run on Android device: ```meteor run android-device```

To run using the app.quranerkotha.com server: ```meteor run android-device --mobile-server https://app.quranerkotha.com/```

