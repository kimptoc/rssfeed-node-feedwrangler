repl = require 'repl'

rssfeed_cli_handler = require './rssfeed-cli-handler'

repl_eval = (cmd, context, filename, callback) ->
  cmd_tweaked = cmd.substring(1,cmd.length-2)
  cmd_array = cmd_tweaked.split(' ')
  cmd_to_call = cmd_array.shift()
  # console.log("You typed:"+JSON.stringify(cmd_tweaked))
  result = undefined
  if (context.handler? and context.handler[cmd_to_call]?) 
    res = context.handler[cmd_to_call](cmd_array)
  else
    try 
      res = eval(cmd_tweaked)
    catch e
      console.log "ERROR:"+e
      console.log(rssfeed_cli_handler.help()) if rssfeed_cli_handler?.help?
  console.log(res) if res?
  callback(null, result)

console.log(rssfeed_cli_handler.help()) if rssfeed_cli_handler?.help?

r = repl.start prompt:'rss> ',eval:repl_eval,ignoreUndefined:true

r.context.handler = rssfeed_cli_handler
