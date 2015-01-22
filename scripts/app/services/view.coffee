#
#   View - Service
#
#   This service controls the current view information by handling routing
#
#

angular.module('Cinexplore').factory 'View', ($routeParams, $route, $rootScope) ->

  new class View

    type = off
    contentType = off
    overlay = off
    viewData = off
    params = off

    $rootScope.$on "$routeChangeSuccess", ($currentRoute, $previousRoute) ->

      fragments = $route.current.view?.split '.'
      overlay = $route.current.overlay

      params = $route.current.params

      type = fragments?[0]
      contentType = fragments?[1]

    type: -> type
    contentType: -> contentType
    overlay: -> overlay

    params: -> params

    getData: -> viewData
    setData: (data) -> viewData = data