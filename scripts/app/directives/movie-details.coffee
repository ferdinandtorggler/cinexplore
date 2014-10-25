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
      scope.loading = yes
      Movies.detail(attrs.movieId).success (movie) ->
        scope.movie = movie
        scope.loading = no

    attrs.$observe 'movieId', fetchInfos