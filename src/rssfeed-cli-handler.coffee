rssfeed = require './rssfeed-local'

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


  feeds: ->
    # console.log "feeds: TODO"
    result = ""
    index = 1
    rssfeed.feeds (err, list) ->
      if list?
        for item in list
          result += "#{item.key}) #{item.feed_url}\n"
          index++
      else
        result = "No feeds"
    return result

  feed: (args) ->
    sub_cmd = args.shift()
    if sub_cmd? and this[sub_cmd]?
      return this[sub_cmd](args)
    else
      return "Unrecognised 'feed' sub-command: #{sub_cmd}"

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

module.exports = new RssFeedCliHandler()