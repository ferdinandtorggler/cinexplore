angular.module('Cinexplore').directive 'snap', ->
  (scope, element) ->
    snapper = new Snap
      element: element[0]
      disable: 'right'
      transitionSpeed: .15
      slideIntent: 40
      addBodyClasses: yes