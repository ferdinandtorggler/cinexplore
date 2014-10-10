angular.module('Cinexplore').directive 'search', (Movies) ->
  restrict: 'EA'
  controller: ($scope) ->
    $scope.search =
      query: ''
    $scope.$watch 'search.query', (query) ->
      $scope.results = [] if query.length <= 2
      if query.length > 2
        Movies.search(query).success (data) ->
          $scope.results = data.results if data.results.length