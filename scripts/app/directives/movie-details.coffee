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
      Movies.similar(attrs.movieId).success (data) ->
        scope.similarMovies = data.results
        scope.loading = no
      Movies.people(attrs.movieId).success (data) ->
        scope.cast = data.cast
        scope.loading = no
      Movies.images(attrs.movieId).success (data) ->
        scope.images = data.backdrops
        scope.loading = no
      Movies.videos(attrs.movieId).success (data) ->
        scope.videos = data.results

    attrs.$observe 'movieId', fetchInfos