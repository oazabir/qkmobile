import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';

import './main.html';

Template.hello.onCreated(function helloOnCreated() {
  // counter starts at 0
  this.counter = new ReactiveVar(0);
});

Template.hello.helpers({
  counter() {
    return Template.instance().counter.get();
  },
});

Template.hello.events({
  'click button'(event, instance) {
    // increment the counter when button is clicked
    instance.counter.set(instance.counter.get() + 1);
  },
});

Meteor.startup(function() {
    // Here we can be sure the plugin has been initialized
    if(Meteor.isCordova){
		var notificationOpenedCallback = function(jsonData) {
			console.log('notificationOpenedCallback: ' + JSON.stringify(jsonData));
		};

		window.plugins.OneSignal
			.startInit("2dcb7944-fe51-4b86-aee6-0ce5e7809d34")
			.handleNotificationOpened(notificationOpenedCallback)
			.endInit();

		// Call syncHashedEmail anywhere in your app if you have the user's email.
		// This improves the effectiveness of OneSignal's "best-time" notification scheduling feature.
		// window.plugins.OneSignal.syncHashedEmail(userEmail);
	}
});
