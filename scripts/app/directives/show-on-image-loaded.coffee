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