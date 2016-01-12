env = require './env.coffee'

window.oalert = window.alert
window.alert = (err) ->
	window.oalert err.data.error
window.Promise = require 'promise'
window._ = require 'underscore'
window.$ = require 'jquery'
window.$.deparam = require 'jquery-deparam'
if env.isNative()
	window.$.getScript 'cordova.js'


require 'ngCordova'

require 'angular-activerecord'

require 'angular-http-auth'
require 'angular-touch'

require 'tagDirective'
require 'angular-translate'
require 'angular-translate-loader-static-files'


require 'util.auth'

require './app.coffee'
require './controller.coffee'
require './model.coffee'
require './locale.coffee'
require './platform.coffee'
