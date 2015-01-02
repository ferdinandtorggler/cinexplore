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

angular.module('Cinexplore').directive 'movieList', ($timeout, Movies) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'movie-list.html'
  link: (scope, elem, attrs) ->


    capitalize = (string) -> string.charAt(0).toUpperCase() + string.slice 1
    setTitle = (title) -> scope.title = capitalize title

    resetView = ->
      scope.page = 1
      scope.movies = []

    handleResult = (data) ->
      scope.loading = no
      scope.movies = scope.movies.concat data.results
      scope.page = data.page + 1 if data.page

    fetchMovies = (category = 'popular', genre) ->

      scope.loading = yes if scope.page is 1
      if attrs.mlGenre
        Movies.genre(attrs.mlGenre).success handleResult
      else if category
        Movies[category](scope.page).success handleResult

    scope.fetchMovies = fetchMovies

    attrs.$observe 'mlCategory', (category) ->
      resetView()
      fetchMovies category
      setTitle category

    attrs.$observe 'mlGenre', (genre) ->
      resetView()
      if genre
        fetchMovies 'genre', genre
        $timeout -> setTitle attrs.mlGenreName # let name rendering happen first