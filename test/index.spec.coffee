http = require 'http'
koa = require 'koa'
request = require 'supertest'

noBot = require '../src/index'

yaml = require("js-yaml")
fs = require("fs")

allBrowsers = yaml.load(fs.readFileSync("./test/fixtures/browsers.yml"))
allBots = yaml.load(fs.readFileSync("./test/fixtures/crawlers.yml"))

describe 'index', ->
  beforeEach ->
    @app = koa()
    @app.use noBot()
    @app.use (next) ->
      @status = 200
      yield next
    @server = http.createServer @app.callback()

  for name, eachBots of allBots
    for type, bots of eachBots
      describe "browser #{type}", ->
        for bot in bots
          describe "ua #{bot}", ->
            it 'ignores the browser', (done) ->
              request(@server)
              .get '/'
              .set 'User-Agent', bot
              .expect 400
              .end done

  for name, eachBrowsers of allBrowsers
    for type, browsers of eachBrowsers
      describe "browser #{type}", ->
        for browser in browsers
          describe "ua #{browser}", ->
            it 'rejects the bot', (done) ->
              request(@server)
              .get '/'
              .set 'User-Agent', browser
              .expect 200
              .end done

  describe "bots option", ->
    beforeEach ->
      @app = koa()
      @app.use noBot(bots: [{name: "foo", regexp: "bar"}])
      @app.use (next) ->
        @status = 200
        yield next
      @server = http.createServer @app.callback()

    it "rejects the bot", (done) ->
      request(@server)
      .get '/'
      .set 'User-Agent', "bar"
      .expect 400
      .end done

    it "ignores the other bots", (done) ->
      request(@server)
      .get '/'
      .set 'User-Agent', "bur"
      .expect 200
      .end done

  describe "callback option", ->
    beforeEach ->
      @app = koa()
      @app.use noBot callback: ->
        @throw 402
      @app.use (next) ->
        @status = 200
        yield next
      @server = http.createServer @app.callback()

    it "rejects the bot", (done) ->
      request(@server)
      .get '/'
      .set 'User-Agent', "crawler"
      .expect 402
      .end done
