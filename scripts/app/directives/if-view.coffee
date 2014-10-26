angular.module('Cinexplore').directive 'ifView', (ngIfDirective, Navigation) ->
  transclude: ngIfDirective[0].transclude
  priority: ngIfDirective[0].priority
  terminal: ngIfDirective[0].terminal
  restrict: ngIfDirective[0].restrict
  link: (scope, element, attrs) ->
    view = attrs.ifView
    attrs.ngIf = -> view is Navigation.current().view
    ngIfDirective[0].link.apply ngIfDirective[0], arguments
