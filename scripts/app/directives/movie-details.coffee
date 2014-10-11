angular.module('Cinexplore').directive 'movieDetails', ($timeout, Movies) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'movie-details.html'
  link: (scope, elem, attrs) ->

    scope.toggleTrailer = ->
      if scope.playing
        scope.playing = no
        scope.trailerVisible = no
      else
        scope.playing = yes
        $timeout (-> scope.trailerVisible = yes), 300

    fetchInfos = ->
      Movies.detail(attrs.movieId).success (movie) ->
        scope.movie = movie
      Movies.similar(attrs.movieId).success (data) ->
        scope.similarMovies = data.results
      Movies.people(attrs.movieId).success (data) ->
        scope.cast = data.cast
      Movies.images(attrs.movieId).success (data) ->
        scope.images = data.backdrops
      Movies.videos(attrs.movieId).success (data) ->
        scope.videos = data.results

    attrs.$observe 'movieId', fetchInfos