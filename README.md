# koa-no-bot

[![NPM version][npm-image]][npm-link]
[![Build Status][build-image]][build-link]
[![Coverage Status][coverage-image]][coverage-link]
[![dependency Status][dep-image]][dep-link]
[![devDependency Status][dev-dep-image]][dev-dep-link]

Switch env per request.

## Usage

```javascript
var koa = require('koa');
var noBot = require('koa-no-bot');

app = koa();
app.use(noBot());
```

## Options

### bots

Define callback to be executed.

```javascript
app = koa();

var bots = [{
  name: "Custom Bots"
  regexp: /(bots|botts)/i
}]
app.use(noBot({ "bots": bots });
```

### callback

Define callback to be executed.

```javascript
app = koa();
app.use(noBot({ "callback": function(bot, ua){ // Do Something } }));
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2015 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.


[npm-image]: https://badge.fury.io/js/koa-no-bot.svg
[npm-link]: http://badge.fury.io/js/koa-no-bot
[build-image]: https://secure.travis-ci.org/dtaniwaki/koa-no-bot.svg
[build-link]:  http://travis-ci.org/dtaniwaki/koa-no-bot
[coverage-image]: https://img.shields.io/coveralls/dtaniwaki/koa-no-bot.svg
[coverage-link]: https://coveralls.io/r/dtaniwaki/koa-no-bot
[dep-image]: https://david-dm.org/dtaniwaki/koa-no-bot/status.svg
[dep-link]: https://david-dm.org/dtaniwaki/koa-no-bot#info=dependencies
[dev-dep-image]: https://david-dm.org/dtaniwaki/koa-no-bot/dev-status.svg
[dev-dep-link]: https://david-dm.org/dtaniwaki/koa-no-bot#info=devDependencies
