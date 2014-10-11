angular.module('Cinexplore').controller 'NavigationCtrl', ($scope) ->

  $scope.navigation =
    view: 'list'
    category: 'popular'
    movieId: off
    personId: off

    toList: (category) ->
      @category = category
      @view = 'list'

    toGenre: (id) ->
      @genre = id
      @toList 'genre'

    toPerson: (id) ->
      @personId = id
      @view = 'person'

    toMovie: (id) ->
      @movieId = id
      @view = 'movie'

