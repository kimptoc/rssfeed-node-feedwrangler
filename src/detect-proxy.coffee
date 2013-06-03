portcheck = require 'portchecker'

detectProxy = (request_defaults = {}, callback) ->
  try
    portcheck.isOpen 8888,"localhost", (is_open)->
      # console.log "Port is open? #{is_open}"
      if is_open
        # console.log "Found the proxy, so use it:#{is_open}"
        request_defaults.proxy = "http://localhost:8888"
      callback?(request_defaults)
  catch e
    # console.log "Proxy not found, so connecting direct:#{e}"
    callback?(request_defaults)

module.exports = detectProxy
