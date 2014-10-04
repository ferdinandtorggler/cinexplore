app = angular.module 'Cinexplore', ['ngRoute']

require './services/movies'

require './directives/movie-list'
require './directives/snap'
require './directives/menu'

require './filters/image-path'