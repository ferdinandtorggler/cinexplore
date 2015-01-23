#
# Open Menu - Directive
#
# This attribute directive makes it's element open the menu when clicked.
#
#

angular.module('Cinexplore').directive 'openMenu', ->
  restrict: 'A'
  link: (scope, element) ->
    element.on 'click', ->
      scope.$apply -> $scope.$emit 'menu-open'