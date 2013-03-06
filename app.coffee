
# Module dependencies.
express = require('express')
http = require('http')
path = require('path')

extend = (object, properties) ->
  for key, val of properties
    object[key] = val
  object

merge = (options, overrides) ->
  extend (extend {}, options), overrides

build_method = (instance, method,initial) ->
  () =>
    if arguments.length == 0
      initial(instance)
    else
      a = {}
      a[method] = arguments[0]
      return new Task2(a)

class Model

  @field = (name) ->
    @fields ?= []
    @fields.push(name)

#  constructor: (attributes) ->
#    @attributes = {}
#    console.log(@constructor.fields)
#
#    for name of @constructor.fields
#      Model::[name] = build_method(name, -> attributes[name])

class Task2 extends Model
  @field "desc"

  constructor: (@attributes) ->
    s2 = this
    do (s2) ->
      Task2::["desc"] = build_method(s2,"desc", (s) -> s.attributes["desc"])


#t = new Task("description": "ASDF")
#t3 = new Task("description": "X")

#t2 = t.description("ASDF2")
#console.log t.description()
#console.log t2.description()

t = new Task2("desc":"X")
t2 = new Task2("desc":"Y")
console.log(t.desc() == "X")
console.log(t2.desc() == "Y")

console.log(t2.desc("Z").desc() == "Z")

console.log(t.desc() == "X")
console.log(t2.desc() == "Y")


app = express()

app.configure ->
  app.set('port', process.env.PORT || 3000)
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router)
  app.use(express.static(path.join(__dirname, 'www')))

app.configure 'development', ->
  app.use(express.errorHandler())

app.get '/', (req,res) ->
  res.redirect("/index.html")

http.createServer(app).listen app.get('port'), ->
  console.log("Express server listening on port " + app.get('port'))
