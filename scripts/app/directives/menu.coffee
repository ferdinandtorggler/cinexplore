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
  controller: ($scope) ->
    Movies.genres().success (data) -> $scope.genres = data.genres