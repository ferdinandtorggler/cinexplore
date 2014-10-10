angular.module('Cinexplore').directive 'openOverlay', (Overlays) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply ->
        Overlays.open attrs.openOverlay
