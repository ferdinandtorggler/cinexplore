APP_NAME = 'Cinexplore'
deviceready = -> angular.bootstrap document, [APP_NAME]

mockCordova = ->
  window.backbutton = ->
    document.dispatchEvent new Event 'backbutton'

  window.offline = ->
    document.dispatchEvent new Event 'offline'

  window.online = ->
    document.dispatchEvent new Event 'online'


initialize = ->
  angular.module APP_NAME, []
  if window.cordova
    document.addEventListener 'deviceready', deviceready, no
  else
    mockCordova()
    setTimeout deviceready

module.exports = initialize