angular.module('Cinexplore').directive 'colorFromImage', ($http) ->
  (scope, elem, attrs) ->
    p = $http.jsonp "http://localhost:3000/api?image=#{attrs.colorFromImage}", params:
      callback: 'JSON_CALLBACK'

    p.success (res) -> elem[0].style.backgroundColor = "##{res.color}"