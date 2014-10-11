angular.module('Cinexplore').directive 'closeMenu', ->
  restrict: 'A'
  link: (scope, element) ->
    element[0].addEventListener 'click', ->
      scope.$emit 'menu-close'
