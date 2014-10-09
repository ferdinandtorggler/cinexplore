app = angular.module 'Cinexplore', ['ngRoute']

require './services/movies'

require './directives/movie-list'
require './directives/movie-details'
require './directives/snap'
require './directives/swiper'
require './directives/menu'

require './filters/image-path'