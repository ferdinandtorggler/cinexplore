#
#   Image Path - Filter
#
#   This filter turns a filename from The Movie Database into
#   a url. If a size is specified, the generated link points to
#   the image in that specific size.
#
#

angular.module('Cinexplore').filter 'imagePath', ->

  IMAGE_BASE = 'http://image.tmdb.org/t/p/'

  (filename, size) ->
    size = 185 if size is 'thumb'
    if size and filename
      "#{IMAGE_BASE}w#{size}#{filename}"
    else if filename
      "#{IMAGE_BASE}original#{filename}"
    else
      ""
