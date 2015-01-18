#
#   Dominant Color - Service
#
#   This service interacts with a service for extracting the dominant color from an image.
#
#

angular.module('Cinexplore').factory 'Colors', ($http, $rootScope) ->

  BASE_URL = 'http://dominantcolor.herokuapp.com/api/'
  HEX_COLOR_REGEX = /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
  $rootScope.PRIMARY_COLOR = '#FFC026'
  setUIToPrimaryColor = -> $rootScope.uiColor = $rootScope.PRIMARY_COLOR
  isValidHex = (color) -> HEX_COLOR_REGEX.test color
  setUIToPrimaryColor()

  new class Colors

    fromImage: (url) ->
      $http.jsonp BASE_URL, params:
        image: url
        callback: 'JSON_CALLBACK'

    fromImages: (urls) ->
      $http.jsonp BASE_URL, params:
        images: urls.join(',')
        callback: 'JSON_CALLBACK'

    isValidHex: isValidHex

    resetUIColor: setUIToPrimaryColor

    setUIColor: (color) ->
      $rootScope.uiColor = if isValidHex color then color else $rootScope.PRIMARY_COLOR