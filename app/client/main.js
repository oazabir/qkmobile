import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';

import './main.html';

Meteor.startup(function() {
  console.log("Application startup");  

  // Here we can be sure the plugin has been initialized
  if(Meteor.isCordova){
    var notificationOpenedCallback = function(jsonData) {
      console.log('notificationOpenedCallback: ' + JSON.stringify(jsonData));
    };

    console.log("Initialize onesignal");
    //window.plugins.OneSignal.setLogLevel({logLevel: 6, visualLevel: 4});
    window.plugins.OneSignal
      .startInit("2dcb7944-fe51-4b86-aee6-0ce5e7809d34")
      .handleNotificationOpened(notificationOpenedCallback)
      .endInit();
    console.log("Initialized onesignal");
    window.plugins.OneSignal.getIds(function(ids) {
        console.log('getIds: ' + JSON.stringify(ids));
    });

    // Call syncHashedEmail anywhere in your app if you have the user's email.
    // This improves the effectiveness of OneSignal's "best-time" notification scheduling feature.
    // window.plugins.OneSignal.syncHashedEmail(userEmail);
  }

  if(Meteor.isClient) {
    var iframe = $('#iframe');
    var lastPath = window.localStorage.getItem("lastPath");
    if (lastPath) {
      if (lastPath != '/index/index.html') {
        iframe.attr('src', lastPath);
      }
    }
    iframe.on("load", function() {
      var path = $('#iframe').contents()[0].location.pathname;
      console.log(path);
      window.localStorage.setItem("lastPath", path);
    });
  }

});
