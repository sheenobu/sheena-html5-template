
# Module dependencies.
express = require('express')
http = require('http')
path = require('path')

app = express()

app.configure ->
  app.set('port', process.env.PORT || 5000)
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router)
  app.use(express.static(path.join(__dirname, 'www')))

app.configure 'development', ->
  app.use(express.errorHandler())
  app.get '/env.yml', (req,res) ->
    res.send("test: true")

app.configure 'production', ->
  app.get '/env.yml', (req,res) ->
    res.send("test: false")

app.get '/', (req,res) ->
  res.redirect("/index.html")

http.createServer(app).listen app.get('port'), ->
  console.log("Express server listening on port " + app.get('port'))
