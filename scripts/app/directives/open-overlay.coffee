angular.module('Cinexplore').directive 'openOverlay', ($parse, Overlays) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply ->
        Overlays.open attrs.openOverlay, $parse(attrs.ooData)()
