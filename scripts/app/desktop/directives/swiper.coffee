#
# Swiper - Directive
#
# This directive provides an interface to the iDangero.us Swiper API to its element.
# For custom interaction with the swiper this directive exposes a variable which contains
# the Swiper object.
# 
# Parameters:
#     s-options: {json} iDangerou.us Swiper configuration object.
#     s-var:     {string} Variable name to expose the swiper variable.
#

angular.module('Cinexplore').directive 'swiper', ($parse, $timeout) ->
  restrict: 'EA'
  link: (scope, element, attrs) ->

    createSlider = ->
      options = $parse(attrs.sOptions)() or {}
      swiper = new Swiper element[0], options

      scope[attrs.sVar] = swiper
      scope.$broadcast 'swiper-created'

    $timeout createSlider, 100