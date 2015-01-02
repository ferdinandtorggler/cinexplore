#
# Navigate - Directive
#
# This attribute directive adds a click listener which navigates to a given view.
#
# Parameters:
#     navigate:        {string} A view identifier.
#     n-data:          {json} Data which can be accessed from the view as 'viewData'
#     n-clear-history: {boolean} The navigation clears all history when 'true'.
#                                Useful when navigating to the main view.
#

angular.module('Cinexplore').directive 'navigate', ($parse, Navigation) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element[0].addEventListener 'click', ->
      scope.$apply ->
        Navigation.navigate attrs.navigate, $parse(attrs.nData)(), $parse(attrs.nClearHistory)()
