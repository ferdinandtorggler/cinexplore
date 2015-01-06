#
# On Scroll End - Directive
#
# This attribute directive triggers a given action by evaluating an expression
# against the current scope when scrolling towards the end of the contents of its
# element.
# Useful for lazy-loading additional content.
#
# Parameters:
#     on-scroll-end: {expression} The action to trigger.
#

angular.module('Cinexplore').directive 'onScrollEnd', ($timeout, $rootScope) ->


  (scope, elem, attrs) ->

    elem = elem[0]
    parent = elem.parentNode

    parent.addEventListener 'scroll', ->
      height = elem.offsetHeight
      containerHeight = parent.offsetHeight

      if (parent.scrollTop + containerHeight) >= height * .8
        scope.$eval attrs.onScrollEnd