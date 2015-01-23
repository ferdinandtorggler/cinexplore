#
# Menu - Directive
#
# This directive renders the menu layout and fetches menu contents for the use
# inside the template.
#
#

angular.module('Cinexplore').directive 'menu', (Movies) ->
  restrict: 'EA'
  templateUrl: 'menu.html'
  controller: ($scope, $rootScope) ->

    $rootScope.$on 'menu-open', -> $scope.open = true
    $rootScope.$on 'menu-close', -> $scope.open = false

    Movies.genres().success (data) -> $scope.genres = data.genres