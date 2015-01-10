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

angular.module('Cinexplore').directive 'movieDetails', ($timeout, $parse, $filter, Movies, Navigation, Colors) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'movie-details.html'
  link: (scope, elem, attrs) ->

    applyBasicMovieInfos = (basicData) ->
      scope.loaded = no
      scope.movie = $parse(basicData)()

    fetchInfos = ->
      scope.loading = yes
      scope.swiper.swipeTo 0 if scope.swiper
      Movies.detail(attrs.movieId).success (movie) ->
        scope.movie = movie
        scope.movie.images.all = scope.movie.images.posters[0..0].concat scope.movie.images.backdrops
        scope.loaded = yes
        scope.loading = no

        colors = Colors.fromImages movie.similar.results.map (item) -> $filter('imagePath')(item.poster_path, 92)
        colors.success (res) -> scope.coverColors = res.colors

    scope.toggleTrailer = ->
      scope.trailerPlaying = !scope.trailerPlaying

    attrs.$observe 'movieBasicData', applyBasicMovieInfos
    attrs.$observe 'movieId', fetchInfos