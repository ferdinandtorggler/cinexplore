angular.module('Cinexplore').directive 'swiper', ($parse) ->
    restrict: 'EA'
    link: (scope, element, attrs) ->
        options = $parse(attrs.options)() or {}
        console.log options
        scope.swiper = new Swiper element[0], options