import { Meteor } from 'meteor/meteor';
import { Logger }        from 'meteor/ostrio:logger';
import { LoggerConsole } from 'meteor/ostrio:loggerconsole';

Meteor.startup(() => {

  WebApp.rawConnectHandlers.use(function(req, res, next) {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Headers", "Authorization,Content-Type");
    return next();
  });
  
  // code to run on server at startup
  const log = new Logger();
  // Initialize and enable LoggerConsole with custom formatting:
  (new LoggerConsole(log, {
    format(opts) {
      return ((Meteor.isServer) ? '[SERVER]' : "[CLIENT]") + ' [' + opts.level + '] - ' + opts.message;
    }
  })).enable();

  log.info("Started logger");
});
