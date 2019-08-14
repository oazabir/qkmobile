#rm -rf public
#ln -s ../quranerkotha.com public
meteor create .
meteor npm install --save @babel/runtime@latest
meteor add-platform android
meteor add ostrio:loggerconsole
meteor add ostrio:logger
meteor add themeteorchef:bert
meteor add cordova:onesignal-cordova-plugin@2.5.2
meteor add cordova:cordova-plugin-statusbar@2.4.3
meteor add cordova:cordova-plugin-splashscreen@5.0.3
