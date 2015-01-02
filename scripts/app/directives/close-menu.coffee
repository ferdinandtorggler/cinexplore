#
# Close Menu - Directive
#
# This attribute directive adds a click listener to its element which causes the
# Menu to close on click.
#
#

angular.module('Cinexplore').directive 'closeMenu', ->
  restrict: 'EA'
  link: (scope, element) ->
    element[0].addEventListener 'click', ->
      scope.$emit 'menu-close'
