angular.module('Cinexplore').directive 'movieDetails', (Movies) ->
    scope: yes
    restrict: 'EA'
    templateUrl: 'movie-details.html'
    link: (scope, elem, attrs) ->
        Movies.detail(187).success (data) ->
            scope.movie = data.results