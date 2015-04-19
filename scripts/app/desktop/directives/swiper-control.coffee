#
# Swiper Control - Directive
#
# Define actions to be triggered on a specific slider, such as next and prev.
# 
# Parameters:
#     swiper-control: {Swiper} A swiper instance
#     sc-action:      {string} [next, prev]
#     sc-event:       {string} Event which triggers the action, Defaults to 'click'
#

angular.module('Cinexplore').directive 'swiperControl', ($parse, $timeout) ->
  restrict: 'A'
  link: (scope, element, attrs) ->

    scope.$on 'swiper-created', ->

      swiper = scope[attrs.swiperControl]
      event = attrs.scEvent || 'click'

      element.bind event, ->
        switch attrs.scAction
          when 'next' then swiper.swipeNext()
          when 'prev' then swiper.swipePrev()
