#
# Open Overlay - Directive
#
# This attribute directive makes it's element open a given overlay when clicked.
# Custom overlay-data can be passed in (see parameters) and can be retrieved in
# the overlay's scope via overlay.data
#
# Parameters:
#       open-overlay: {string} The name of the overlay to open
#       oo-data: {json} A JavaScript-object which is made available inside the overlay
#

angular.module('Cinexplore').directive 'openOverlay', ($parse, Overlays) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply ->
        Overlays.open attrs.openOverlay, $parse(attrs.ooData)()
