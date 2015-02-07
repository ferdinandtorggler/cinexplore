#
# Close Overlay - Directive
#
# This attribute directive adds a click listener to its element. On click,
# the current overlay is closed.
#
#

angular.module('Cinexplore').directive 'closeOverlay', (Overlays) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply -> Overlays.close()
