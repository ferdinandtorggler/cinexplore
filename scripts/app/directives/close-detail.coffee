angular.module('Cinexplore').directive 'closeDetail', ($parse, Navigation) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply -> Navigation.toList()
