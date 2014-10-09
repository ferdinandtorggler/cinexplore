angular.module('Cinexplore').directive 'movieDetails', (Movies) ->
    scope: yes
    restrict: 'EA'
    templateUrl: 'movie-details.html'
    link: (scope, elem, attrs) ->
        Movies.detail(attrs.movieId).success (movie) ->
            scope.movie = movie
        Movies.similar(attrs.movieId).success (data) ->
            scope.similarMovies = data.results
        Movies.people(attrs.movieId).success (data) ->
            scope.cast = data.cast
        Movies.images(attrs.movieId).success (data) ->
            scope.images = data.backdrops