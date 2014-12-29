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

    attrs.$observe 'mlCategory', (category) ->
      resetView()
      fetchMovies category
      setTitle category

    attrs.$observe 'mlGenre', (genre) ->
      resetView()
      if genre
        fetchMovies 'genre', genre
        $timeout -> setTitle attrs.mlGenreName # let name rendering happen first