#
# Add Class On Load - Directive
#
# This directive adds a class to an element when its element's load event has fired.
#
# Parameters:
#     add-class-on-load:   {string} The class name
#     acol-target:         {string} The element the class should be added to
#     acol-src:            {string} An image source to be loaded. Not necessary if element is an <img>
#     acol-closest-target: {boolean} When set to true, target will be the closest element matching the selector
#

angular.module('Cinexplore').directive 'addClassOnLoad', ($timeout, Utils) ->
  link: (scope, element, attrs) ->

    className = attrs.addClassOnLoad
    selector = attrs.acolTarget
    useClosest = attrs.acolClosestTarget is 'true'
    target = element[0]

    addClass = -> target.classList.add className

    if selector
      target = Utils.closest element[0], selector if useClosest
      target = document.querySelector selector unless useClosest

    attrs.$observe 'acolSrc', ->
      if attrs.acolSrc
        bgImg = new Image
        bgImg.onload = addClass
        $timeout -> bgImg.src = attrs.acolSrc

    element[0].onload = addClass
      