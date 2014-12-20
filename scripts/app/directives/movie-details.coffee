angular.module('Cinexplore').directive 'movieDetails', ($timeout, $parse, Movies, Navigation) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'movie-details.html'
  link: (scope, elem, attrs) ->

    applyBasicMovieInfos = (basicData) ->
      scope.loaded = no
      scope.movie = $parse(basicData)()

    fetchInfos = ->
      scope.loading = yes
      Movies.detail(attrs.movieId).success (movie) ->
        scope.movie = movie
        scope.loaded = yes
        scope.loading = no

    scope.toggleTrailer = ->
      scope.trailerPlaying = !scope.trailerPlaying

    attrs.$observe 'movieBasicData', applyBasicMovieInfos
    attrs.$observe 'movieId', fetchInfos