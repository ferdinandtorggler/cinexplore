#
# If View - Directive
#
# This attribute directive is a more specific version of angulars built in ngIf directive.
# It adds or removes its element from the DOM depending on whether the current view matches
# a given view-type.
#
# Parameters:
#     if-view: {string} The type of the view on which the element should be added to the DOM
#

angular.module('Cinexplore').directive 'ifView', (ngIfDirective, View) ->
  transclude: ngIfDirective[0].transclude
  priority: ngIfDirective[0].priority
  terminal: ngIfDirective[0].terminal
  restrict: ngIfDirective[0].restrict
  link: (scope, element, attrs) ->
    view = attrs.ifView
    fragments = view.split '.'

    attrs.ngIf = ->
      current = View.type()
      if current
        render = yes
        render = no if View.type() isnt fragments[0]
        render = no if View.contentType() and View.contentType() isnt fragments[1]
        return render
      
    ngIfDirective[0].link.apply ngIfDirective[0], arguments
