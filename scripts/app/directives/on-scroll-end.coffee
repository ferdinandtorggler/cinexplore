angular.module('Cinexplore').directive 'onScrollEnd', ($timeout) ->


  (scope, elem, attrs) ->
    
    elem = elem[0]

    setup = ->

      parent = elem.parentNode

      height = elem.offsetHeight
      containerHeight = parent.offsetHeight

      listener = ->
        if (parent.scrollTop + containerHeight) >= height * .8
          console.log 'fire'
          scope.$eval attrs.onScrollEnd
          parent.removeEventListener 'scroll', listener
          $timeout setup, 1000

      parent.addEventListener 'scroll', listener
      
    $timeout setup, 1000
