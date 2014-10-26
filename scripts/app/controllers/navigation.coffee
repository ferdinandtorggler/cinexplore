angular.module('Cinexplore').controller 'NavigationCtrl', ($scope) ->

  $scope.navigation =
    view: 'list'
    category: 'popular'
    movieId: off
    personId: off

    toList: (category) ->
      @category = category
      @view = 'list'

    toAbout: ->
      @view = 'about'

    toGenre: (id, name) ->
      @genre = id
      @genreName = name
      @toList 'genre'

    toPerson: (id) ->
      @personId = id
      @view = 'person'

    toMovie: (id) ->
      @movieId = id
      @view = 'movie'

