#
# Search - Directive
#
# This directive is used for the search view. It listens to the search field input
# and searches the API for movies and people.
#
#

angular.module('Cinexplore').directive 'search', (Movies) ->
  restrict: 'EA'
  controller: ($scope) ->
    $scope.search =
      query: ''
    $scope.$watch 'search.query', (query) ->
      if query.length <= 2
        $scope.movies = []
        $scope.people = []
      if query.length > 2
        Movies.search(query).success (data) ->
          $scope.movies = data.results if data.results.length
        Movies.search(query, 'person').success (data) ->
          $scope.people = data.results if data.results.length