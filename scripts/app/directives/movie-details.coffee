angular.module('Cinexplore').directive 'movieDetails', (Movies) ->
    scope: yes
    restrict: 'EA'
    templateUrl: 'movie-details.html'
    link: (scope, elem, attrs) ->
        Movies.detail(100).success (movie) ->
            scope.movie = movie
        Movies.similar(100).success (data) ->
            scope.similarMovies = data.results
        Movies.people(100).success (data) ->
            scope.cast = data.cast
        Movies.images(100).success (data) ->
            scope.images = data.backdrops