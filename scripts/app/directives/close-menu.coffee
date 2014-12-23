angular.module('Cinexplore').directive 'closeMenu', ->
  restrict: 'EA'
  link: (scope, element) ->
    element[0].addEventListener 'click', ->
      scope.$emit 'menu-close'
