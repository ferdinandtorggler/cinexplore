angular.module('Cinexplore').directive 'overlay', (Overlays) ->
  restrict: 'EA'
  controller: ($scope, $element, $attrs) ->
    $scope.$watch Overlays.current, (currentOverlay) ->
      if currentOverlay is $attrs.overlayName
        $element.removeClass 'ng-hide'
      else
        $element.addClass 'ng-hide'