angular.module('Cinexplore').directive 'dominantColor', ($filter, Colors) ->
  (scope, elem, attrs) ->

    prevUrl = off

    scope.$watch ->
      return if attrs.dcImageUrl is prevUrl
      promise = Colors.fromImage attrs.dcImageUrl
      prevUrl = attrs.dcImageUrl
      promise.success (res) ->
        scope[attrs.dcVar] = "##{res.color}"
