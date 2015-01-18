#
# Movie List - Directive
#
# This directive renders the template for the movie list and the associated data.
# Parameters are used to control the data feched by the directive.
#
# Parameters:
#     ml-category:   {string} A movie category (e.g. popular)
#     ml-genre:      {number} A genre ID
#     ml-genre-name: {string} The name of the genre when a genre ID is provided.
#

angular.module('Cinexplore').directive 'movieList', ($timeout, $rootScope, $filter, Movies, Navigation, Colors) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'movie-list.html'
  link: (scope, elem, attrs) ->

    scope.colors = []
    capitalize = (string) -> string.charAt(0).toUpperCase() + string.slice 1
    setTitle = (title) -> scope.title = capitalize title
    fetching = no

    toggleLoadingIndicator = ->
      if scope.loading
        scope.loading = no
      else
        scope.loading = yes if scope.page is 1

    extractColors = (movies) ->
      return unless movies
      promise = Colors.fromImages movies.map (item) -> $filter('imagePath')(item.backdrop_path, 300)
      promise.success (res) -> scope.colors = res.colors

    resetView = ->
      scope.page = 1
      scope.movies = []

    handleResult = (data) ->
      toggleLoadingIndicator()
      scope.movies = scope.movies.concat data.results
      extractColors scope.movies
      scope.page = data.page + 1 if data.page
      fetching = no

    fetchMovies = (category = 'popular', genre) ->
      return if fetching
      fetching = yes
      if genre
        toggleLoadingIndicator()
        Movies.genre(genre, scope.page).success handleResult
      else if category
        toggleLoadingIndicator()
        Movies[category](scope.page).success handleResult

    scope.fetchMovies = fetchMovies

    lastCategory = off
    attrs.$observe 'mlCategory', (category) ->
      return if lastCategory and category is lastCategory
      lastCategory = category if category
      if category
        resetView()
        fetchMovies category
        setTitle category

    attrs.$observe 'mlGenre', (genre) ->
      if genre
        resetView()
        fetchMovies 'genre', genre
        $timeout -> setTitle attrs.mlGenreName # let name rendering happen first