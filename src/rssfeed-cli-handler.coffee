rssfeed = require './rssfeed-feedwrangler'

class RssFeedCliHandler
  
  constructor: ->
    # console.log "RssFeedCliHandler:ctor"

  help: ->
    return "Commands available:\n"+
      " *) help - this help\n"+
      " *) feeds - list of your feeds\n"+
      " *) feed add 'feed url' - add a feed\n"+
      " *) clear all - remove all feeds\n"+
      " *) login\n"


  feeds: (args, callback) ->
    # console.log "feeds: TODO"
    result = ""
    index = 1
    rssfeed.feeds (err, list) ->
      # console.log "err:#{err}, list:#{list.length}"
      if list?
        for item in list
          result += "#{index}) #{item.feed_url}\n"
          # console.log "...#{result}"
          index++
      else
        result = "No feeds"
      callback?(result)

  feed: (args, callback) ->
    sub_cmd = args.shift()
    if sub_cmd? and this[sub_cmd]?
      this[sub_cmd] args, callback
    else
      callback("Unrecognised 'feed' sub-command: #{sub_cmd}")

  clear: (args) ->
    sub_cmd = args.shift()
    if sub_cmd? and sub_cmd.toLowerCase() == 'all'
      rssfeed.clear()
      return "All feeds have been removed"
    else 
      return "ERROR: Unrecognised clear option"

  add: (args) ->
    rssfeed.add args[0], (err) ->
      if err?
        return "ERROR adding: #{args[0]}: #{err}"
      else
        return "added: #{args[0]}"

  login: (args, callback) ->
    user = args[0]
    pass = args[1]
    rssfeed.login user, pass, (err) ->
      if err?
        callback("ERROR logging in: #{args[0]}: #{err}")
      else
        callback("logged in: #{args[0]}")

module.exports = new RssFeedCliHandler()
