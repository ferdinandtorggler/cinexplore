#
# Open Menu - Directive
#
# This attribute directive makes it's element open the menu when clicked.
#
#

angular.module('Cinexplore').directive 'openMenu', ->
  restrict: 'A'
  link: (scope, element) ->
    element[0].addEventListener 'click', ->
      scope.$emit 'menu-open'