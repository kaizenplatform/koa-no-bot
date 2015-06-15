var middleware;

middleware = function(options) {
  var bots, callback, ref;
  ref = options || {}, bots = ref.bots, callback = ref.callback;
  bots || (bots = middleware.default_bots);
  callback || (callback = function(bot, ua) {
    return this["throw"](400);
  });
  return function*(next) {
    var bot, i, len, ua;
    ua = this.get("user-agent");
    for (i = 0, len = bots.length; i < len; i++) {
      bot = bots[i];
      if (ua.match(bot.regexp)) {
        console.log("Found " + bot.name + " (" + bot.regexp + "):", ua);
        callback.apply(this, [bot, ua]);
      }
    }
    return (yield next);
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