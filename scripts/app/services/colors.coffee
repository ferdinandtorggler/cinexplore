#
#   Dominant Color - Service
#
#   This service interacts with a service for extracting the dominant color from an image.
#
#

angular.module('Cinexplore').factory 'Colors', ($http) ->

  BASE_URL = 'http://dominantcolor.herokuapp.com/api/'

  new class Colors

    fromImage: (url) ->
      $http.jsonp BASE_URL, params:
        image: url
        callback: 'JSON_CALLBACK'

    fromImages: (urls) ->
      $http.jsonp BASE_URL, params:
        images: urls.join(',')
        callback: 'JSON_CALLBACK'