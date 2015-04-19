#
# Color From Image - Directive
#
# This attribute directive changes the CSS background-color property of its element
# to the dominant color of a given image.
#
# Parameters:
#     color-from-image: {string} An image url to extract the color from
#

angular.module('Cinexplore').directive 'colorFromImage', (Colors) ->
  (scope, elem, attrs) ->
    attrs.$observe 'colorFromImage', ->
    p = Colors.fromImage attrs.colorFromImage
    p.success (res) -> elem[0].style.backgroundColor = "##{res.color}"