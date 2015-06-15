middleware = (options) ->
  { bots, callback } = options || {}
  bots ||= middleware.default_bots
  callback ||= (bot, ua) ->
    @throw 400

  (next) ->
    ua = @get("user-agent")
    for bot in bots
      if ua.match(bot.regexp)
        console.log "Found #{bot.name} (#{bot.regexp}):", ua
        callback.apply(@, bot, ua)

    yield next

middleware.default_bots = [{
  name: "General Bots"
  regexp: /(bot\b|spider\b|crawler\b|wget|slurp|Mediapartners-Google|YahooSeeker)/i
}]

module.exports = middleware
