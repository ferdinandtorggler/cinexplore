APP_NAME = 'Cinexplore'
deviceready = -> angular.bootstrap document, [APP_NAME]

initialize = ->
  angular.module APP_NAME, []
  if window.cordova
    document.addEventListener 'deviceready', deviceready, no
  else
    setTimeout deviceready

module.exports = initialize