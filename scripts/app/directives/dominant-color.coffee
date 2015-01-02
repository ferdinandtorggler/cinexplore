#
# Dominant Color - Directive
#
# This attribute directive extracts the dominant color from an image and writes it
# into a variable on the scope. The name of that variable must be set (see parameters).
#
# Parameters:
#     dc-image-url: {string} An image url to extract the color from
#     dc-var:       {string} The scope variable name
#

angular.module('Cinexplore').directive 'dominantColor', ($filter, Colors) ->
  (scope, elem, attrs) ->

    prevUrl = off

    scope.$watch ->
      return if attrs.dcImageUrl is prevUrl
      promise = Colors.fromImage attrs.dcImageUrl
      prevUrl = attrs.dcImageUrl
      promise.success (res) ->
        scope[attrs.dcVar] = "##{res.color}"
