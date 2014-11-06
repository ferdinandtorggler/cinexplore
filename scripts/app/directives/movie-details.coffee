angular.module('Cinexplore').directive 'movieDetails', ($timeout, Movies) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'movie-details.html'
  link: (scope, elem, attrs) ->

    closeTrailerText = 'Close Trailer'
    openTrailerText = 'Watch Trailer'

    scope.trailerText = openTrailerText

    afterAnimating = (callback) ->
      $timeout callback, 300

    scope.toggleTrailer = ->
      if scope.playing
        scope.playing = no
        scope.trailerVisible = no
        afterAnimating -> scope.trailerText = openTrailerText
      else
        scope.playing = yes
        scope.trailerText = closeTrailerText
        afterAnimating -> scope.trailerVisible = yes
          
    fetchInfos = ->
      scope.loading = yes
      Movies.detail(attrs.movieId).success (movie) ->
        scope.movie = movie
        scope.loading = no

    attrs.$observe 'movieId', fetchInfos