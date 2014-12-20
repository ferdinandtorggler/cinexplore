angular.module('Cinexplore').directive 'colorFromImage', (Colors) ->
  (scope, elem, attrs) ->
    p = Colors.fromImage attrs.colorFromImage
    p.success (res) -> elem[0].style.backgroundColor = "##{res.color}"