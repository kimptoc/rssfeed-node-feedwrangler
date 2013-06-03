
should = require('should')
rssfeed = require('../lib/rssfeed-local')

describe 'rssfeed', ->
  describe 'feed list without logging in', ->
    it 'gives error when login required and you dont login', (done) ->
      rssfeed.setRequiresLogin(true)
      rssfeed.requiresLogin().should.equal true
      rssfeed.feeds (err, feeds) ->
        should.exist err
        should.not.exist feeds
        done()

    it 'gives empty list when login not required and you dont login', (done) ->
      rssfeed.setRequiresLogin(false)
      rssfeed.requiresLogin().should.equal false
      rssfeed.feeds (err, feeds) ->
        should.not.exist err
        should.exist feeds
        feeds.length.should.equal 0
        done()

  describe 'login', ->
    it 'fail', (done) ->
      rssfeed.login 'token1','token2invalid', (err) ->
        should.exist err
        done()

    it 'ok', (done) ->
      rssfeed. setLogin 'token1','token2'
      rssfeed.login 'token1','token2', (err) ->
        should.not.exist err
        done()

  describe 'adding', ->
    it 'add one feed', (done) ->
      rssfeed.clear()
      rssfeed.setRequiresLogin(false)
      #TODO - not a valid feed, a real backend would probably reject this...
      rssfeed.feeds (err, feeds) ->
        feeds.length.should.equal 0
        rssfeed.add 'http://blahblah', (err) ->
          should.not.exist err
          rssfeed.feeds (err, feeds) ->
            feeds.length.should.equal 1
            done()

    it 'add two feeds', (done) ->
      rssfeed.clear()
      rssfeed.setRequiresLogin(false)
      #TODO - not a valid feed, a real backend would probably reject this...
      rssfeed.add 'http://blahblah1', (err) ->
        rssfeed.add 'http://blahblah2', (err) ->
          rssfeed.feeds (err, feeds) ->
            feeds.length.should.equal 2
            done()