angular.module('Cinexplore').directive 'overlay', (Overlays) ->
  restrict: 'EA'
  transclude: on
  templateUrl: 'overlay.html'
  controller: ($scope, $element, $attrs) ->

    $scope.overlay = {}

    $scope.$watch Overlays.current, (currentOverlay) ->
      $scope.overlay.data = Overlays.currentData()
      console.log $scope.overlay.data
      if currentOverlay is $attrs.overlayName
        $element.removeClass 'ng-hide'
        $scope.overlay.visible = yes
      else
        $scope.overlay.visible = no
        $element.addClass 'ng-hide'