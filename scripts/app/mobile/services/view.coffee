#
#   View - Service
#
#   This service controls the current view information by handling routing
#
#

angular.module('Cinexplore').factory 'View', ($routeParams, $route, $rootScope, $location) ->

  new class View

    type = off
    contentType = off
    overlay = off
    viewData = off
    params = off

    lastListRoute = '/'

    $rootScope.$on "$routeChangeSuccess", ($currentRoute, $previousRoute) ->

      fragments = $route.current?.view?.split '.'
      overlay = $route.current.overlay

      params = $route.current.params

      type = fragments?[0]
      contentType = fragments?[1]

      lastListRoute = $location.path() if type is 'list'

    type: -> type
    contentType: -> contentType
    overlay: -> overlay

    params: -> params

    getData: -> viewData
    setData: (data) -> viewData = data

    toList: -> $location.path lastListRoute