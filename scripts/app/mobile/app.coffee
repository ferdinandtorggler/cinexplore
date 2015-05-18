APP_NAME = 'Cinexplore'
APP_DEPENDENCIES = ['templates', 'ngAnimate', 'ngRoute', 'matchmedia-ng', 'afkl.lazyImage']

angular.module APP_NAME, APP_DEPENDENCIES
angular.module(APP_NAME).run ($rootScope) ->
  $rootScope.icons = 'icons/symbol/svg/sprite.symbol.svg'
  
setTimeout ->
  angular.bootstrap document, [APP_NAME]
