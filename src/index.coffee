middleware = (options) ->
  { bots, callback } = options || {}
  bots ||= middleware.default_bots
  callback ||= (bots, ua) ->
    for bot in bots
      console.log "Found #{bot.name} (#{bot.regexp}):", ua
    @throw 400

  (next) ->
    ua = @get("user-agent")
    matchedBots = []
    for bot in bots
      if ua.match(bot.regexp)
        matched = true
        matchedBots.push bot
    if matchedBots.length > 0
      callback.apply(@, [matchedBots, ua])
    else
      yield next

middleware.default_bots = [{
  name: "General Bots"
  regexp: /(bot\b|spider\b|crawler\b|wget|slurp|Mediapartners-Google|YahooSeeker)/i
}]

module.exports = middleware
