#
# If View - Directive
#
# This attribute directive is a more specific version of angulars built in ngIf directive.
# It adds or removes its element from the DOM depending on whether the current view matches
# a given view-name.
#
# Parameters:
#     if-view: {string} The name of the view on which the element should be added to the DOM
#

angular.module('Cinexplore').directive 'ifView', (ngIfDirective, Navigation) ->
  transclude: ngIfDirective[0].transclude
  priority: ngIfDirective[0].priority
  terminal: ngIfDirective[0].terminal
  restrict: ngIfDirective[0].restrict
  link: (scope, element, attrs) ->
    view = attrs.ifView

    attrs.ngIf = ->
      current = Navigation.current()
      if current
        scope.viewData = current.data
        current.view is view
      
    ngIfDirective[0].link.apply ngIfDirective[0], arguments
