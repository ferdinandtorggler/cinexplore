deviceready = -> angular.bootstrap document, ['Cinexplore']
document.addEventListener 'deviceready', deviceready, no

app = angular.module 'Cinexplore', ['ngRoute']

require './controllers/navigation'

require './services/movies'
require './services/overlays'

require './directives/movie-list'
require './directives/movie-details'
require './directives/person-details'
require './directives/open-overlay'
require './directives/close-overlay'
require './directives/search'
require './directives/snap'
require './directives/overlay'
require './directives/swiper'
require './directives/menu'
require './directives/close-menu'
require './directives/open-menu'
require './directives/loading'
require './directives/back-button'

require './filters/image-path'
require './filters/youtube-url'