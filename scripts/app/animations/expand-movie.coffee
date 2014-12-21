angular.module('Cinexplore').animation '.expand-movie', ->

  enter: (elem, done) ->
    elem = elem[0]

    elements =
      teaser: elem.querySelector '.teaser'
      tabs: elem.querySelector 'tabs'
      details: elem.querySelector '.detail-container'

    initialPosition = window.innerHeight

    animation = new TimelineMax
      onComplete: done
      ease: Strong.easeOut

    animation.set elem,
      top: initialPosition
      opacity: 0

    animation.to elem, .4,
      top: 0
      opacity: 1