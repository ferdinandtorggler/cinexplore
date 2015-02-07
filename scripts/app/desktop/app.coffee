APP_NAME = 'Cinexplore'
APP_DEPENDENCIES = ['templates', 'ngAnimate', 'ngRoute', 'matchmedia-ng']

angular.module APP_NAME, APP_DEPENDENCIES
setTimeout ->
  angular.bootstrap document, [APP_NAME]

require '../common/services/overlays'
require './directives/main-loading'

require '../common/directives/overlay'
require '../common/directives/open-overlay'
require '../common/directives/close-overlay'