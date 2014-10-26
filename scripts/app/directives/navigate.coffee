angular.module('Cinexplore').directive 'navigate', ($parse, Navigation) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      Navigation.navigate attrs.navigate, $parse(attrs.n-data)()
