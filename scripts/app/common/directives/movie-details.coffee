#
# Movie Details - Directive
#
# This directive contains the logic for the movie detail view. The main purpose is
# fetching movie information and rendering it to the page using the appropriate
# template.
# If part of a movie's data is already available it can be passed to the directive, so
# that part of the content shows up immediately. That data will eventually be completed.
#
# Parameters:
#     movie-id:         {number} The movie id
#     movie-basic-data: {object} Basic movie data, which is probably available from a list.
#

angular.module('Cinexplore').directive 'movieDetails', ($timeout, $parse, $filter, Movies, View, Colors) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'movie-details.html'
  link: (scope, elem, attrs) ->

    chunk = (array, chunk) ->
      i = 0
      j = array.length
      chunked = []
      i = 0
      j = array.length
      while i < j
        temparray = array.slice i, i + chunk
        chunked.push temparray
        i += chunk
      return chunked

    setUIColor = (color) ->
      return unless Colors.isValidHex color
      Colors.setUIColor color
      scope.dominantColor = color

    applyBasicMovieInfos = (basicData) ->
      scope.loaded = no
      scope.movie = basicData.movie
      setUIColor basicData.color if basicData.color

    fetchUIColor = (movie) ->
      uiColor = Colors.fromImage $filter('imagePath')(movie.backdrop_path, 300)
      uiColor.success (res) -> setUIColor "##{res.color}"

    fetchSimilarMoviesColors = (movie) ->
      return unless movie.similar.results.length
      coverColors = Colors.fromImages movie.similar.results.map (item) -> $filter('imagePath')(item.poster_path, 92)
      backdropColors = Colors.fromImages movie.similar.results.map (item) -> $filter('imagePath')(item.backdrop_path, 300)
      coverColors.success (res) -> scope.coverColors = res.colors
      backdropColors.success (res) -> scope.backdropColors = res.colors

    fetchInfos = (id) ->
      scope.loading = yes
      scope.swiper.swipeTo 0 if scope.swiper
      Movies.detail(id).success (movie) ->
        scope.movie = movie
        scope.movie.images.all = scope.movie.images.posters[0..0].concat scope.movie.images.backdrops
        scope.movie.images.chunked = chunk scope.movie.images.all, 15
        scope.movie.videos.trailers = scope.movie.videos.results.filter (video) -> video.type is 'Trailer'
        scope.loaded = yes
        scope.loading = no
        fetchSimilarMoviesColors movie
        fetchUIColor movie unless scope.dominantColor

    scope.toggleTrailer = ->
      scope.trailerPlaying = !scope.trailerPlaying

    scope.$watch View.params, (params) ->
      scope.loaded = no
      applyBasicMovieInfos View.getData()
      fetchInfos params.id

    $timeout ->
      if elem[0].classList.contains 'expand-movie-animation'
        elem[0].classList.add 'expand-movie-animation--trigger'