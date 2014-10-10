angular.module('Cinexplore').directive 'swiper', ($parse, $timeout) ->
  restrict: 'EA'
  link: (scope, element, attrs) ->

    createSlider = ->
      options = $parse(attrs.sOptions)() or {}
      scope.swiper = new Swiper element[0], options

    $timeout createSlider, 100