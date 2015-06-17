middleware = (options) ->
  { bots, callback } = options || {}
  bots ||= middleware.default_bots
  callback ||= (bot, ua) ->
    console.log "Found #{bot.name} (#{bot.regexp}):", ua
    @throw 403

  (next) ->
    ua = @get("user-agent")
    for bot in bots
      if ua.match(bot.regexp)
        callback.apply(@, [bot, ua])
        return
    yield next

middleware.default_bots = [{
  name: "General Bots"
  regexp: /(bot\b|spider\b|crawler\b|\bwget\b|\bcurl\b|Yahoo ad|slurp|Mediapartners-Google|YahooSeeker)/i
}]

module.exports = middleware
