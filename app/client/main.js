// import { Template } from 'meteor/templating';
// import { ReactiveVar } from 'meteor/reactive-var';
// import { Logger } from 'meteor/ostrio:logger';
// import { LoggerConsole } from 'meteor/ostrio:loggerconsole';
import './main.html';

// const HOME_HASH = '#home'
// const INDEX_PAGE_PATH = '/index/index.html' + HOME_HASH;
// const ONESIGNAL_KEY = "2dcb7944-fe51-4b86-aee6-0ce5e7809d34";

// (function () {

//   var log;
//   var userId = "";
//   function userLogInfo(log, message) {
//     log.info('[' + userId + '] ' + message);
//   }

//   function userLogError(log, message, params) {
//     log.error('[' + userId + '] ' + message, params);
//   }

//   Meteor.startup(function () {
//     console.log("Application startup");
//     // Initialize Logger:
//     log = setupLogger();

//     // Here we can be sure the plugin has been initialized
//     if (Meteor.isCordova) {
//       var notificationOpenedCallback = function (jsonData) {
//         console.log('notificationOpenedCallback: ' + JSON.stringify(jsonData));
//       };

//       setupOneSignal(notificationOpenedCallback, log);
//     }

//     if (Meteor.isClient) {
//       /* Store original window.onerror */
//       var _GlobalErrorHandler = window.onerror;
//       setupGlobalErrorHandler(log, _GlobalErrorHandler);

//       if (typeof Bert === "undefined") {
//         userLogError("Bert is undefined", {}, {});
//       }

//       var ALERT_DELAY = 3000;
//       var needToShowAlert = true;
//       needToShowAlert = configureReload(log, needToShowAlert, ALERT_DELAY);

//       var iframe = $('#iframe');

//       // Auto resize iFRAME to fit whole window periodically
//       setupAutoResizeIframe(iframe);
//       // Pressing back button on homepage should quite the app
//       setupBackButtonForExit(iframe);

//       if (window.localStorage) {

//         // If user was reading an article, then load that article page
//         var lastPath = reloadLastArticle(iframe);

//         iframe
//           .on("error", function () {
//             logIframeLoadError(log, lastPath, iframe);
//           })
//           .on("load", function () {
//             // Remember the last article loaded so that we can reload it when app starts
//             var path = iframeLocation(iframe).pathname;
//             rememberLastPath(iframe, path, log);

//             rememberVisitedLinks(path);

//             changeVisitedLinks(iframe);

//           });
//       }
//     }

//   });

//   function logIframeLoadError(log, lastPath, iframe) {
//     userLogError(log, "Failed to load IFRAME", { lastPath: lastPath });
//     window.localStorage.setItem("lastPath", INDEX_PAGE_PATH);
//     iframe.src = INDEX_PAGE_PATH;
//   }

//   function changeVisitedLinks(iframe) {
//     var viewedLinks = eval(window.localStorage.getItem("visitedItems") || "[]");
//     $('a', iframe.contents()[0]).each(function () {
//       var href = $(this).attr('href');
//       for (var i = 0; i < viewedLinks.length; i++) {
//         if (viewedLinks[i].length > 3) {
//           if (href.indexOf(viewedLinks[i]) >= 0) {
//             $(this).addClass('visited');
//           }
//         }
//       }
//     });
//   }

//   function rememberVisitedLinks(path) {
//     var visitedLinks = window.localStorage.getItem("visitedItems");
//     if (visitedLinks) {
//       visitedLinks = eval(visitedLinks);
//     }
//     else {
//       visitedLinks = [];
//     }
//     if ($.inArray(path, visitedLinks) < 0) {
//       visitedLinks.push(path);
//     }
//     if (visitedLinks.length > 100) {
//       visitedLinkes = visitedLinks.slice(0, 100);
//     }
//     window.localStorage.setItem("visitedItems", JSON.stringify(visitedLinks));
//   }

//   function rememberLastPath(iframe, path, log) {
//     if (iframeLocation(iframe).hash != HOME_HASH) {
//       window.localStorage.setItem("lastPath", path);
//       userLogInfo(log, "Read: " + path);
//     }
//   }

//   function setupBackButtonForExit(iframe) {
//     function onDeviceReady() {
//       document.addEventListener("backbutton", function (e) {
//         if (iframeLocation(iframe).hash == HOME_HASH) {
//           e.preventDefault();
//           navigator.app.exitApp();
//         }
//         else {
//           navigator.app.backHistory();
//         }
//       }, false);
//     }
//     document.addEventListener("deviceready", onDeviceReady, false);
//   }

//   function reloadLastArticle(iframe) {
//     var lastPath = window.localStorage.getItem("lastPath") || INDEX_PAGE_PATH;
//     if (lastPath != INDEX_PAGE_PATH) {
//       iframe.attr('src', lastPath + HOME_HASH);
//     }
//     else {
//     }
//     return lastPath;
//   }

//   function setupAutoResizeIframe(iframe) {
//     window.setInterval(function () {
//       if (window.innerWidth > 100) {
//         iframe.css('width', window.innerWidth + 'px');
//         iframe.css('height', window.innerHeight + 'px');
//       }
//     }, 1000);
//   }

//   function configureReload(log, needToShowAlert, ALERT_DELAY) {
//     try {
//       Reload._onMigrate(function (retry) {
//         userLogInfo(log, "Reload._onMigrate fired");
//         if (needToShowAlert) {
//           try {
//             console.log('going to reload in 3 seconds...');
//             Bert.alert('নতুন আর্টিকেল এসেছে!', 'success', 'growl-bottom-right');
//             // After reload, go back to home page so that user 
//             // sees new article
//             window.localStorage.setItem("lastPath", INDEX_PAGE_PATH);
//           }
//           catch (x) {
//           }
//           needToShowAlert = false;
//           _.delay(function () {
//             try {
//               retry();
//               userLogInfo(log, 'Reloaded');
//             }
//             catch (e) {
//               userLogError(log, e.message, {});
//             }
//           }, ALERT_DELAY);
//           return [false];
//         }
//         else {
//           return [true];
//         }
//       });
//       Bert.alert('নতুন আর্টিকেল এসেছে কিনা দেখছি...', 'info', 'growl-top-right');
//     }
//     catch (e) {
//       userLogError(log, e.message, {});
//     }
//     return needToShowAlert;
//   }

//   function setupGlobalErrorHandler(log, errorHandler) {
//     window.onerror = (msg, url, line) => {
//       //log.error(msg, {file: url, onLine: line});
//       userLogError(log, msg, { file: url, onLine: line });
//       if (errorHandler) {
//         errorHandler.apply(this, arguments);
//       }
//     };
//   }

//   function setupLogger() {
//     const log = new Logger();
//     // Initialize and enable LoggerConsole with custom formatting:
//     (new LoggerConsole(log, {
//       format(opts) {
//         return ((Meteor.isServer) ? '[SERVER]' : "[CLIENT]") + ' [' + opts.level + '] - ' + opts.message;
//       }
//     })).enable();
//     return log;
//   }

//   function setupOneSignal(notificationOpenedCallback, log) {
//     console.log("Initialize onesignal");

//     try {
//       window.plugins.OneSignal
//         .startInit(ONESIGNAL_KEY)
//         .handleNotificationOpened(notificationOpenedCallback)
//         .endInit();
//       console.log("Initialized onesignal");
//       window.plugins.OneSignal.getIds(function (ids) {
//         console.log('getIds: ' + JSON.stringify(ids));
//         userId = ids.userId;
//         userLogInfo(log, 'OneSignal Logged in.');
//       });
//     }
//     catch (e) {
//       console.log(e);
//     }
//   }

//   function iframeLocation(iframe) {
//     return iframe.contents()[0].location;
//   }


// });