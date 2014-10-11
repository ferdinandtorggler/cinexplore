angular.module('Cinexplore').directive 'movieList', ($timeout, Movies) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'movie-list.html'
  link: (scope, elem, attrs) ->

    capitalize = (string) -> string.charAt(0).toUpperCase() + string.slice 1
    setTitle = (title) -> scope.title = capitalize title

    fetchMovies = (category = 'popular', genre) ->
      setTitle category
      Movies[category](attrs.mlGenre).success (data) ->
        scope.movies = data.results

    attrs.$observe 'mlCategory', (category) -> fetchMovies category
    attrs.$observe 'mlGenre', (genre) ->
      if genre
        fetchMovies 'genre', genre
        $timeout -> setTitle attrs.mlGenreName # let name rendering happen first