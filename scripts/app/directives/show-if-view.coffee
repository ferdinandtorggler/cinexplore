#
# Show If View - Directive
#
# This attribute directive is a more specific version of angulars built in ngShow directive.
# It shows or hides its element via 'ng-hide' depending on whether the current view matches
# a given view-name.
#
# Parameters:
#     show-if-view: {string} The name of the view on which the element should be shown
#

angular.module('Cinexplore').directive 'showIfView', (ngShowDirective, Navigation) ->
  link: (scope, element, attrs) ->
    view = attrs.showIfView

    scope.$watch Navigation.current, ->
      current = Navigation.current()
      scope.viewData = current.data
      console.log current.view
      console.log view
      console.log element[0]
      console.log if current.view is view then 'remove' else 'add'
      element[0].classList[if current.view is view then 'remove' else 'add'] 'ng-hide'
