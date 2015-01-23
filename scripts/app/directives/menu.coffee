#
# Menu - Directive
#
# This directive renders the menu layout and fetches menu contents for the use
# inside the template.
#
#

angular.module('Cinexplore').directive 'menu', (Movies, $rootScope) ->
  restrict: 'EA'
  templateUrl: 'menu.html'
  controller: ($scope) ->

    openMenu = ->
      $rootScope.menuOpen = yes
      $scope.open = yes

    closeMenu = ->
      $rootScope.menuOpen = no
      $scope.open = no

    $scope.$on 'menu-open', openMenu
    $scope.$on 'menu-close', closeMenu

    Movies.genres().success (data) -> $scope.genres = data.genres