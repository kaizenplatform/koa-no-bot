var middleware;

middleware = function(options) {
  var bots, callback, ref;
  ref = options || {}, bots = ref.bots, callback = ref.callback;
  bots || (bots = middleware.default_bots);
  callback || (callback = function(bot, ua) {
    console.log("Found " + bot.name + " (" + bot.regexp + "):", ua);
    return this["throw"](403);
  });
  return function*(next) {
    var bot, i, len, ua;
    ua = String(this.get("user-agent"));
    for (i = 0, len = bots.length; i < len; i++) {
      bot = bots[i];
      if (ua.match(bot.regexp)) {
        callback.apply(this, [bot, ua]);
        return;
      }
    }
    return (yield next);
  };
};

middleware.default_bots = [
  {
    name: "General Bots",
    regexp: /(bot\b|spider\b|crawler\b|\bwget\b|\bcurl\b|Yahoo ad|slurp|Mediapartners-Google|YahooSeeker|BingPreview)/i
  }, {
    name: "No User Agent",
    regexp: /^(|null|undefined|)$/i
  }
];

module.exports = middleware;

//# sourceMappingURL=index.js.map
