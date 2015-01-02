#
# Show On Image Loaded - Directive
#
# This attribute directive hides its element until a given image
# is loaded. The element will get two classes in order to enable
# CSS transitions as well:
#     'show-on-image-loaded'         - immediately added, stays
#     'show-on-image-loaded--hidden' - immediately added, removed when image is loaded
#
# Parameters:
#       show-on-image-loaded: {string} The image url to load.
#

angular.module('Cinexplore').directive 'showOnImageLoaded', ->

  directiveClass = 'show-on-image-loaded'
  hiddenClass = 'show-on-image-loaded--hidden'

  (scope, elem, attrs) ->

    elem[0].classList.add directiveClass
    elem[0].classList.add hiddenClass

    img = new Image()
    img.classList.add 'ng-hide'
    img.onload = ->
      elem[0].classList.remove hiddenClass
      img.parentNode.removeChild img
    img.src = attrs.showOnImageLoaded
    elem[0].parentNode.insertBefore img, elem[0].nextSibling