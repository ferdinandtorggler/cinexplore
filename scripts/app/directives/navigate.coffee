angular.module('Cinexplore').directive 'navigate', ($parse, Navigation) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply ->
        Navigation.navigate attrs.navigate, $parse(attrs.nData)(), $parse(attrs.nClearHistory)()
