#
# Navigate - Directive
#
# This attribute directive adds a click listener which navigates to a given view.
#
# Parameters:
#     navigate: {string} A route.
#     n-data:   {json} Data which can be accessed using the View service as View.getData()
#

angular.module('Cinexplore').directive 'navigate', ($parse, $location, View) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply ->
        View.setData $parse(attrs.nData)()
        $location.path attrs.navigate