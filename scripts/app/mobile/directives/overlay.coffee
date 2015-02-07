#
# Overlay - Directive
#
# This directive adds the overlay template and handles overlay-visibility.
#
# Parameters:
#       overlay-name: {string} The name of the overlay
#

angular.module('Cinexplore').directive 'overlay', ($animate, Overlays) ->
  restrict: 'EA'
  transclude: on
  templateUrl: 'overlay.html'
  controller: ($scope, $element, $attrs) ->

    $scope.overlay = {}

    setVisibility = (show) ->
      $scope.overlay.visible = show
      method = if show then 'addClass' else 'removeClass'
      $animate[method] $element, 'overlay-visible'

    $scope.$watch Overlays.current, (currentOverlay) ->
      $scope.overlay.data = Overlays.currentData()
      setVisibility currentOverlay is $attrs.overlayName