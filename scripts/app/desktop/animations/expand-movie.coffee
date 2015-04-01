angular.module('Cinexplore').animation '.expand-movie-animation', ->
  
  initialPosition = 0
  console.log 'wat'

  addClass: (elem, className, done) ->

    console.log className

    return if className isnt 'expand-movie-animation--trigger'

    elem = elem[0]
    elements =
      teaser: elem.querySelector '.teaser'
      tabs: elem.querySelector 'tabs'
      details: elem.querySelector '.detail-container'

    initialPosition = elem.getBoundingClientRect().top
    animation = new TimelineLite
      onComplete: done
      ease: Strong.easeOut

    animation.set elem,
      top: '100%'

    # return

    console.log initialPosition

    console.log elem
    console.log elements.detail

    animation.to elem, 0.40, top: '0', 0
    # animation.from elem, 5.4, height: 205, 0
    # animation.to elements.teaser, 5.4, height: 260, .2
    # animation.from elements.details, 5.4, height: 0, 0
    # animation.from elements.tabs, 5.4, height: 0, 0

  # beforeRemoveClass: (elem, className, done) ->
  #   return if className isnt trigger
  #   elem = elem[0]
  #   elements =
  #     teaser: elem.querySelector '.teaser'
  #     tabs: elem.querySelector 'tabs'
  #     details: elem.querySelector '.detail-container'

  #   complete = ->
  #     console.log 'completed'
  #     done()

  #   animation = new TimelineLite onComplete: complete
  #   animation.to elem, .2, top: initialPosition, 0
  #   animation.to elem, .4, height: 205, 0
  #   animation.to elements.teaser, .4, height: 205, 0
  #   animation.to elements.details, .4, height: 0, 0
  #   animation.to elements.tabs, .4, height: 0, 0
