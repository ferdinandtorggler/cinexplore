APP_NAME = 'Cinexplore'
APP_DEPENDENCIES = ['templates', 'ngAnimate', 'ngRoute', 'matchmedia-ng', 'afkl.lazyImage']

angular.module APP_NAME, APP_DEPENDENCIES
angular.module(APP_NAME).run ($rootScope) ->
  $rootScope.icons = 'icons/symbol/svg/sprite.symbol.svg'

setTimeout ->
  angular.bootstrap document, [APP_NAME]

require './animations/expand-movie'

require '../common/services/overlays'
require './directives/main-loading'

require '../common/directives/movie-list'
require '../common/directives/movie-details'
require '../common/directives/show-on-image-loaded'
require '../common/services/movies'
require '../common/services/view'
require '../common/services/colors'

require '../common/router'

require '../common/directives/overlay'
require '../common/directives/open-overlay'
require '../common/directives/close-overlay'
require '../common/directives/navigate'
require '../common/directives/if-view'
require '../common/directives/show-if-view'
require '../common/directives/broadcast-on-scroll-end'

require '../common/filters/image-path'
require '../common/filters/youtube-url'