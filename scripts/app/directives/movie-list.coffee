angular.module('Cinexplore').directive 'movieList', (Movies) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'movie-list.html'
  link: (scope, elem, attrs) ->

    fetchMovies = (category = 'popular', genre) ->
      Movies[category](attrs.mlGenre).success (data) ->
        scope.movies = data.results

    attrs.$observe 'mlGenre', (genre) -> fetchMovies 'genre', genre
    attrs.$observe 'mlCategory', (category) -> fetchMovies category