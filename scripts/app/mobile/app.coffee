APP_NAME = 'Cinexplore'
APP_DEPENDENCIES = ['templates', 'ngAnimate', 'ngRoute', 'matchmedia-ng']

angular.module APP_NAME, APP_DEPENDENCIES
setTimeout ->
  angular.bootstrap document, [APP_NAME]

require './router'

require '../common/services/overlays'
require './services/movies'
require './services/navigation'
require './services/menu'
require './services/colors'
require './services/view'

require '../common/directives/overlay'
require '../common/directives/open-overlay'
require '../common/directives/close-overlay'
require './directives/movie-list'
require './directives/movie-details'
require './directives/person-details'
require './directives/search'
require './directives/snap'
require './directives/swiper'
require './directives/menu'
require './directives/close-menu'
require './directives/open-menu'
require './directives/loading'
require './directives/navigate'
require './directives/if-view'
require './directives/show-if-view'
require './directives/gain-focus'
require './directives/color-from-image'
require './directives/ripple'
require './directives/dominant-color'
require './directives/close-detail'
require './directives/show-on-image-loaded'
require './directives/broadcast-on-scroll-end'

require './filters/image-path'
require './filters/youtube-url'

