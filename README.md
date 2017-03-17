# Quraner Kotha mobile app version
Mobile app that serves Quranerkotha.com in offline mode. It detects new changes on the website and updates the local cache. Also supports push notification receiving from main QK site.

# Getting started

Install meteor.

Clone the repository.

Create a symbolic link to map ./quranetkotha.app/public to ./quranerkotha.com folder. 

```
quranerkotha.app$ ln -s ../quranerkotha.com public
```

On Windows, go to command prompt using Administrator. Then use ```mklink /D public ..\quranerkotha.com``` inside the auranerkotha.app folder. 

Go inside quranerkotha.app

run the app using ```meteor run```

