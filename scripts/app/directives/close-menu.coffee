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
    element.on 'click', ->
      scope.$apply -> scope.$emit 'menu-close'
