angular.module('Cinexplore').directive 'openMenu', ->
  restrict: 'A'
  link: (scope, element) ->
    element[0].addEventListener 'click', ->
      scope.$emit 'menu-open'