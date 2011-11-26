Zombie = require("./zombie/browser")
Sys = require("sys")

# Constructor for a new Browser. Takes no arguments.
exports.Browser = Browser = Zombie.Browser
exports.package = Zombie.package
exports.version = Zombie.version


# ### zombie.visit(url, callback)
# ### zombie.visit(url, options, callback)
#
# Creates a new Browser, opens window to the URL and calls the callback when
# done processing all events.
#
# For example:
#     zombie = require("zombie")
#
#     vows.describe("Brains").addBatch(
#       "seek":
#         topic: ->
#           zombie.browse "http://localhost:3000/brains", @callback
#       "should find": (browser)->
#         assert.ok browser.html("#brains")[0]
#     ).export(module);
#
# * url -- URL of page to open
# * options -- Initialize the browser with these options
# * callback -- Called with error, browser
exports.visit = (url, options, callback)->
  new Browser(options).visit(url, options, callback)


# ### listen port, callback
# ### listen socket, callback
# ### listen callback
#
# Ask Zombie to listen on the specified port for requests.  The default
# port is 8091, or you can specify a socket name.  The callback is
# invoked once Zombie is ready to accept new connections.
exports.listen = (port, callback)->
  require("./zombie/protocol").listen(port, callback)


# console.log(browser) pukes over the terminal, so we apply some sane
# defaults.  You can override these:
# console.depth -       How many time to recurse while formatting the
#                       object (default to zero)
# console.showHidden -  True to show non-enumerable properties (defaults
#                       to false)
console.depth = 0
console.showHidden = false
console.log = ->
  formatted = ((if typeof arg == "string" then arg else Sys.inspect(arg, console.showHidden, console.depth)) for arg in arguments)
  process.stdout.write formatted.join(" ") + "\n"