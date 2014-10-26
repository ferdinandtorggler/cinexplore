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
