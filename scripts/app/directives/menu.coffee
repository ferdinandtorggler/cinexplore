angular.module('Cinexplore').directive 'menu', (Movies) ->
  restrict: 'EA'
  templateUrl: 'menu.html'
  controller: ($scope) ->
    Movies.genres().success (data) -> $scope.genres = data.genres