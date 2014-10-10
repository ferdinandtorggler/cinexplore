app = angular.module 'Cinexplore', ['ngRoute']

require './services/movies'
require './services/overlays'

require './directives/movie-list'
require './directives/movie-details'
require './directives/open-overlay'
require './directives/snap'
require './directives/overlay'
require './directives/swiper'
require './directives/menu'

require './filters/image-path'
require './filters/youtube-url'