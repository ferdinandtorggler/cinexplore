APP_NAME = 'Cinexplore'
APP_DEPENDENCIES = ['ngAnimate']

deviceready = -> angular.bootstrap document, [APP_NAME]


# Expose methods to mock native device events.
mockCordova = ->
  window.backbutton = -> document.dispatchEvent new Event 'backbutton'
  window.offline = -> document.dispatchEvent new Event 'offline'
  window.online = -> document.dispatchEvent new Event 'online'


# Setup app by creating angular module and mocking functions
initialize = ->
  angular.module APP_NAME, APP_DEPENDENCIES
  if window.cordova
    document.addEventListener 'deviceready', deviceready, no
  else
    mockCordova()
    setTimeout deviceready

module.exports = initialize