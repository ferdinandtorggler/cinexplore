angular.module('Cinexplore').controller 'NavigationCtrl', ($scope) ->

    $scope.navigation = 
        view: 'list'
        category: 'upcoming'
        movieId: off
        personId: off

        toList: (category) ->
            @category = category
            @view = 'list'

        toPerson: (id) ->
            @personId = id
            @view = 'person'

        toMovie: (id) ->
            @movieId = id
            @view = 'movie'

