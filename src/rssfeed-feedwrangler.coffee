request = require 'request'
_ = require 'underscore'

detectProxy = require './detect-proxy'

FW_URL = 'https://feedwrangler.net/api/v2'
FW_CLIENT_KEY = process.env.FW_CLIENT_KEY || 'No client key found'

class RssfeedFeedwrangler

  constructor: ->
    @logged_in = false
    @access_token = undefined


  login: (token1, token2, callback) ->
    request_options = 
      uri: FW_URL+"/users/authorize"
      method: "POST"
      form:
        email: token1
        password: token2
        client_key: FW_CLIENT_KEY
    detectProxy request_options, (request_options) =>
      request request_options, (err, res, body) =>
        if err? or !body
          callback?(err || new Error(res.statusCode))
        else
          try
            body = JSON.parse(body)
            if body.error? || !body.access_token
              callback?(body.error || 'No access_token found in login response')
            else
              @access_token = body.access_token
              @logged_in = true
              callback?()
          catch e
            callback?(e.message)
        

  feeds: (callback) ->
    #TODO - check we logged in
    request_options = 
      uri: FW_URL+"/subscriptions/list"
      method: "POST"
      form:
        access_token: @access_token
    detectProxy request_options, (request_options) ->
      request request_options, (err, res, body) ->
        # console.log "feeds/response"
        if err? or !body
          # console.log "error or no body"
          callback?(err || new Error(res.statusCode))
        else
          try
            # console.log "parsing body"
            body = JSON.parse(body)
            if body.error? || !body.feeds
              # console.log "error in body"
              callback?(body.error || 'No feeds found in response')
            else
              # console.log "returning feeds"
              callback?(undefined, body.feeds)
          catch e
            console.log "error parsing body"
            callback?(e.message)

  add: (feed_url, callback) ->
    #TODO - check we logged in
    request_options = 
      uri: FW_URL+"/subscriptions/add_feed"
      method: "POST"
      form:
        feed_url: feed_url
        access_token: @access_token
    detectProxy request_options, (request_options) ->
      request request_options, (err, res, body) ->
        if err? or !body
          callback?(err || new Error(res.statusCode))
        else
          try
            body = JSON.parse(body)
            if body.error?
              callback?(body.error)
            else
              callback?()
          catch e
            callback?(e.message)

  requiresLogin: ->
    true

  clear: (callback)->
    callback?()


module.exports = new RssfeedFeedwrangler()
