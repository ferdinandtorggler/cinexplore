angular.module('Cinexplore').directive 'overlay', (Overlays) ->
  restrict: 'EA'
  transclude: on
  templateUrl: 'overlay.html'
  controller: ($scope, $element, $attrs) ->

    $scope.overlay = {}

    setVisibility = (visible) ->
      $element[if visible then 'removeClass' else 'addClass'] 'ng-hide'
      $scope.overlay.visible = visible
      
    $scope.$watch Overlays.current, (currentOverlay) ->
      $scope.overlay.data = Overlays.currentData()
      setVisibility currentOverlay is $attrs.overlayName