#
# Broadcast On Scroll End - Directive
#
# This attribute directive triggers a given event when scrolling towards
# the end of the contents of its element.
# Useful for lazy-loading additional content.
#
# Parameters:
#     on-scroll-end: {expression} The event to trigger.
#

angular.module('Cinexplore').directive 'broadcastOnScrollEnd', ($timeout, $rootScope) ->

  (scope, elem, attrs) ->

    elem = elem[0]

    window.addEventListener 'scroll', ->
      height = elem.offsetHeight
      containerHeight = window.innerHeight

      if (elem.scrollTop + containerHeight) >= height * .8
        $rootScope.$broadcast attrs.broadcastOnScrollEnd

      return true # native scrolling should not be affected