APP_NAME = 'Cinexplore'
APP_DEPENDENCIES = ['templates', 'ngAnimate', 'ngRoute', 'matchmedia-ng']

angular.module APP_NAME, APP_DEPENDENCIES
setTimeout ->
  angular.bootstrap document, [APP_NAME]

require '../common/services/overlays'
require './directives/main-loading'

require '../mobile/directives/movie-list' # TODO: move to common
require '../common/services/movies' # TODO: move to common
require '../common/services/view' # TODO: move to common
require '../common/services/colors' # TODO: move to common

require '../common/router' # TODO: move to common

require '../common/directives/overlay'
require '../common/directives/open-overlay'
require '../common/directives/close-overlay'

require '../common/filters/image-path' # TODO: move to common