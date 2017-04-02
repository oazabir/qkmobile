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
    window.setInterval(function(){
      iframe.css('width',window.innerWidth+'px');
      iframe.css('height',window.innerHeight+'px');
    }, 1000);
    if (window.localStorage) {
      var lastPath = window.localStorage.getItem("lastPath");
      if (lastPath) {
        if (lastPath != '/index/index.html') {
          iframe.attr('src', lastPath);
        } else {
        }
      }

      iframe.on("load", function() {
        // Remember the last article loaded so that we can reload it when app starts
        var path = iframe.contents()[0].location.pathname;
        console.log(path);
        window.localStorage.setItem("lastPath", path);

        // remember the visited links in an array so that we can mark the hyperlinks as visited
        var visitedLinks = window.localStorage.getItem("visitedItems");
        if (visitedLinks){
          visitedLinks = eval(visitedLinks);
        } else {
          visitedLinks = [];
        }

        if ($.inArray(path, visitedLinks)<0){
          visitedLinks.push(path);
        }

        if (visitedLinks.length > 100) {
          visitedLinkes = visitedLinks.slice(0, 100);
        }
        window.localStorage.setItem("visitedItems", JSON.stringify(visitedLinks));

        var viewedLinks = eval(window.localStorage.getItem("visitedItems") || "[]");
        $('a', iframe.contents()[0]).each(function(){
          var href = $(this).attr('href');
          for (var i = 0; i < viewedLinks.length; i ++){
            if(viewedLinks[i].length > 3){
              if (href.indexOf(viewedLinks[i])>=0) {
                $(this).addClass('visited');
              } 
            }
          }
        });

      });
    }
  }

});
