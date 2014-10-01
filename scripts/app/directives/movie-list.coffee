angular.module('Cinexplore').directive 'movieList', (Movies) ->
    scope: yes
    restrict: 'EA'
    templateUrl: 'movie-list.html'
    link: (scope, elem, attrs) ->
        Movies.popular().success (data) ->
            scope.movies = data.results