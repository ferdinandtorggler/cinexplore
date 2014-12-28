angular.module('Cinexplore').factory 'Colors', ($http) ->

  BASE_URL = 'http://dominantcolor.herokuapp.com/api/'

  new class Colors

    fromImage: (url) ->
      $http.jsonp BASE_URL, params:
        image: url
        callback: 'JSON_CALLBACK'