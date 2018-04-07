import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';
import { Logger }        from 'meteor/ostrio:logger';
import { LoggerConsole } from 'meteor/ostrio:loggerconsole';
import './main.html';

const HOME_HASH = '#home'
const INDEX_PAGE_PATH = '/index/index.html' + HOME_HASH;
const ONESIGNAL_KEY = "2dcb7944-fe51-4b86-aee6-0ce5e7809d34";




Meteor.startup(function () {
  console.log("Application startup");
  // Initialize Logger:
  const log = new Logger();
  // Initialize and enable LoggerConsole with default settings:
  (new LoggerConsole(log)).enable();

  // Initialize and enable LoggerConsole with custom formatting:
  (new LoggerConsole(log, {
    format(opts) {
      return ((Meteor.isServer) ? '[SERVER]' : "[CLIENT]") + ' [' + opts.level + '] - ' + opts.message;
    }
  })).enable();

  log.info("Started logger");

  // Here we can be sure the plugin has been initialized
  if (Meteor.isCordova) {
    var notificationOpenedCallback = function (jsonData) {
      console.log('notificationOpenedCallback: ' + JSON.stringify(jsonData));
    };

    console.log("Initialize onesignal");
    //window.plugins.OneSignal.setLogLevel({logLevel: 6, visualLevel: 4});
    window.plugins.OneSignal
      .startInit(ONESIGNAL_KEY)
      .handleNotificationOpened(notificationOpenedCallback)
      .endInit();
    console.log("Initialized onesignal");
    window.plugins.OneSignal.getIds(function (ids) {
      console.log('getIds: ' + JSON.stringify(ids));
    });

    // Call syncHashedEmail anywhere in your app if you have the user's email.
    // This improves the effectiveness of OneSignal's "best-time" notification scheduling feature.
    // window.plugins.OneSignal.syncHashedEmail(userEmail);

  }

  if (Meteor.isClient) {
    log.info("Client started");
    
    /* Store original window.onerror */
    const _GlobalErrorHandler = window.onerror;

    window.onerror = (msg, url, line) => {
      log.error(msg, {file: url, onLine: line});
      if (_GlobalErrorHandler) {
        _GlobalErrorHandler.apply(this, arguments);
      }
    };
    
    var ALERT_DELAY = 3000;
    var needToShowAlert = true;

    Reload._onMigrate(function (retry) {
      log.info("Reload._onMigrate");

      if (needToShowAlert) {
        try {
          console.log('going to reload in 3 seconds...');
          Bert.alert('নতুন আর্টিকেল এসেছে!', 'success', 'growl-bottom-right');
          window.localStorage.setItem("lastPath", INDEX_PAGE_PATH);
        } catch (x) {

        }
        needToShowAlert = false;
        _.delay(function() {
          try {
            retry();
            log.info("Reloaded.")
          } catch(e) {
            log.error("Reload error: " + e.message);
          }
        }, ALERT_DELAY);
        return [false];
      } else {
        
        return [true];
      }
    });

    Bert.alert('নতুন আর্টিকেল এসেছে কিনা দেখছি...', 'info', 'growl-top-right');

    var iframe = $('#iframe');

    // Auto resize iFRAME to fit whole window periodically
    window.setInterval(function () {
      if (window.innerWidth > 100) {
        iframe.css('width', window.innerWidth + 'px');
        iframe.css('height', window.innerHeight + 'px');
      }
    }, 1000);


    if (window.localStorage) {

      // If user was reading an article, then load that article page
      var lastPath = window.localStorage.getItem("lastPath") || INDEX_PAGE_PATH;
      if (lastPath != INDEX_PAGE_PATH) {
        iframe.attr('src', lastPath + HOME_HASH);
      } else {
      }

      function onDeviceReady() {
        document.addEventListener("backbutton", function (e) {
          if (iframeLocation(iframe).hash == HOME_HASH) {
            e.preventDefault();
            navigator.app.exitApp();
          } else {
            navigator.app.backHistory()
          }
        }, false);
      }
      document.addEventListener("deviceready", onDeviceReady, false);

      iframe.on("load", function () {
        // Remember the last article loaded so that we can reload it when app starts
        var path = iframeLocation(iframe).pathname;
        console.log(path);
        if (iframeLocation(iframe).hash != HOME_HASH) {
          window.localStorage.setItem("lastPath", path);
        }

        // remember the visited links in an array so that we can mark the hyperlinks as visited
        var visitedLinks = window.localStorage.getItem("visitedItems");
        if (visitedLinks) {
          visitedLinks = eval(visitedLinks);
        } else {
          visitedLinks = [];
        }

        if ($.inArray(path, visitedLinks) < 0) {
          visitedLinks.push(path);
        }

        if (visitedLinks.length > 100) {
          visitedLinkes = visitedLinks.slice(0, 100);
        }
        window.localStorage.setItem("visitedItems", JSON.stringify(visitedLinks));

        var viewedLinks = eval(window.localStorage.getItem("visitedItems") || "[]");
        $('a', iframe.contents()[0]).each(function () {
          var href = $(this).attr('href');
          for (var i = 0; i < viewedLinks.length; i++) {
            if (viewedLinks[i].length > 3) {
              if (href.indexOf(viewedLinks[i]) >= 0) {
                $(this).addClass('visited');
              }
            }
          }
        });

      });
    }
  }

});
function iframeLocation(iframe) {
  return iframe.contents()[0].location;
}

