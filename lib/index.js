var middleware;

middleware = function(options) {
  var bots, callback, ref;
  ref = options || {}, bots = ref.bots, callback = ref.callback;
  bots || (bots = middleware.default_bots);
  callback || (callback = function(bots, ua) {
    var bot, i, len;
    for (i = 0, len = bots.length; i < len; i++) {
      bot = bots[i];
      console.log("Found " + bot.name + " (" + bot.regexp + "):", ua);
    }
    return this["throw"](400);
  });
  return function*(next) {
    var bot, i, len, matched, matchedBots, ua;
    ua = this.get("user-agent");
    matchedBots = [];
    for (i = 0, len = bots.length; i < len; i++) {
      bot = bots[i];
      if (ua.match(bot.regexp)) {
        matched = true;
        matchedBots.push(bot);
      }
    }
    if (matchedBots.length > 0) {
      return callback.apply(this, [matchedBots, ua]);
    } else {
      return (yield next);
    }
  };
};

middleware.default_bots = [
  {
    name: "General Bots",
    regexp: /(bot\b|spider\b|crawler\b|wget|slurp|Mediapartners-Google|YahooSeeker)/i
  }
];

module.exports = middleware;

//# sourceMappingURL=index.js.map