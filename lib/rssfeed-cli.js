// Generated by CoffeeScript 1.6.3
(function() {
  var r, repl, repl_eval, rssfeed_cli_handler;

  repl = require('repl');

  rssfeed_cli_handler = require('./rssfeed-cli-handler');

  repl_eval = function(cmd, context, filename, callback) {
    var cmd_array, cmd_to_call, cmd_tweaked, e, res, result;
    cmd_tweaked = cmd.substring(1, cmd.length - 2);
    cmd_array = cmd_tweaked.split(' ');
    cmd_to_call = cmd_array.shift();
    result = void 0;
    if ((context.handler != null) && (context.handler[cmd_to_call] != null)) {
      return context.handler[cmd_to_call](cmd_array, function(res) {
        if (res != null) {
          console.log(res);
        }
        return callback(null, result);
      });
    } else {
      try {
        res = eval(cmd_tweaked);
        if (res != null) {
          console.log(res);
        }
        return callback(null, result);
      } catch (_error) {
        e = _error;
        console.log("ERROR:" + e);
        if ((rssfeed_cli_handler != null ? rssfeed_cli_handler.help : void 0) != null) {
          return console.log(rssfeed_cli_handler.help());
        }
      }
    }
  };

  if ((rssfeed_cli_handler != null ? rssfeed_cli_handler.help : void 0) != null) {
    console.log(rssfeed_cli_handler.help());
  }

  r = repl.start({
    prompt: 'rss> ',
    "eval": repl_eval,
    ignoreUndefined: true
  });

  r.context.handler = rssfeed_cli_handler;

}).call(this);
