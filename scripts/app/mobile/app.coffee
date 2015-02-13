APP_NAME = 'Cinexplore'
APP_DEPENDENCIES = ['templates', 'ngAnimate', 'ngRoute', 'matchmedia-ng', 'afkl.lazyImage']

angular.module APP_NAME, APP_DEPENDENCIES
setTimeout ->
  angular.bootstrap document, [APP_NAME]

require '../common/router'

require '../common/services/overlays'
require '../common/services/movies'
require '../common/services/colors'
require '../common/services/view'
require './services/menu'

require '../common/directives/overlay'
require '../common/directives/open-overlay'
require '../common/directives/close-overlay'
require '../common/directives/navigate'
require '../common/directives/if-view'
require '../common/directives/show-if-view'
require '../common/directives/movie-list'
require '../common/directives/movie-details'
require '../common/directives/show-on-image-loaded'
require './directives/person-details'
require './directives/search'
require './directives/snap'
require './directives/swiper'
require './directives/menu'
require './directives/close-menu'
require './directives/open-menu'
require './directives/loading'
require './directives/gain-focus'
require './directives/color-from-image'
require './directives/ripple'
require './directives/dominant-color'
require './directives/close-detail'
require './directives/broadcast-on-scroll-end'

require '../common/filters/image-path'
require '../common/filters/youtube-url'

