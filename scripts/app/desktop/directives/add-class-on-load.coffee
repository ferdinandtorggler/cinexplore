#
# Add Class On Load - Directive
#
# This directive adds a class to an element when its element's load event has fired.
#
# Parameters:
#     add-class-on-load: {string} The class name
#     acol-target:       {string} The element the class should be added to
#     acol-src:          {string} An image source to be loaded. Not necessary if element is an <img>
#

angular.module('Cinexplore').directive 'addClassOnLoad', ($timeout) ->
  link: (scope, element, attrs) ->

    target = if attrs.acolTarget then document.querySelector attrs.acolTarget else element[0]

    addClass = ->
      console.log 'adding class'
      target.classList.add attrs.addClassOnLoad

    attrs.$observe 'acolSrc', ->
      if attrs.acolSrc
        bgImg = new Image
        bgImg.onload = addClass
        $timeout -> bgImg.src = attrs.acolSrc

    element[0].onload = addClass
      