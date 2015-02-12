#
# Close Detail - Directive
#
# This attribute directive adds a click listener to its element which closes the
# detail-view by navigating back to the last visited list view.
#
#

angular.module('Cinexplore').directive 'closeDetail', ($parse, View, Colors) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply ->
        Colors.resetUIColor()
        View.toList()
