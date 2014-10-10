angular.module('Cinexplore').directive 'closeOverlay', (Overlays) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply -> Overlays.close()
