angular.module('Cinexplore').directive 'movieDetails', (Movies) ->
    scope: yes
    restrict: 'EA'
    templateUrl: 'movie-details.html'
    link: (scope, elem, attrs) ->
        Movies.detail(100).success (movie) ->
            scope.movie = movie
        Movies.similar(100).success (data) ->
            scope.similarMovies = data.results