#
# Draw SVG Path - Directive
#
# This attribute directive draws an svg element slowly
#
#

angular.module('Cinexplore').directive 'mainLoading', ->
  restrict: 'E'
  scope: yes
  link: (scope, element, attrs) ->

    scope.show = yes

    path = element[0].querySelector 'path'
    length = path.getTotalLength()

    prepareShape = ->
      path.style.transition = path.style.WebkitTransition = 'none'
      path.style.strokeDasharray = length + ' ' + length
      path.style.strokeDashoffset = length

    drawShape = ->

      # Trigger a layout so styles are calculated & the browser
      path.getBoundingClientRect()

      path.style.transition = path.style.WebkitTransition = 'stroke-dashoffset 3s linear'
      path.style.strokeDashoffset = '0'


    timeline = new TimelineLite()
    timeline.add prepareShape, 0
    timeline.add (TweenLite.from (element[0].querySelector 'h1'), .5, opacity: 0, transform: 'translateY(10px)'), 0
    timeline.add drawShape, 1

    timeline.add (-> scope.$apply -> scope.show = no), 4