angular.module('Cinexplore').directive 'animationSequence', (Timeline) ->

  controller: ($scope, $element, $attrs) ->

    element = $element[0]

    backgroundImage = 
      element: document.querySelector '.js-background-image'
      to: 
        opacity: .23

    headline = 
      element: document.querySelector '.js-headline'
      from: 
        opacity: 0
        transform: 'translateY(-70px)'

    header =
      element: document.querySelector '.js-header'
      up:
        top: '20%'

    tagline = 
      element: document.querySelector '.js-tagline'
      from:
        opacity: 0
        transform: 'translateY(30px)'
      fadeOut:
        opacity: 0

    rating = 
      whole: document.querySelector '.js-rating-whole'
      part: document.querySelector '.js-rating-part'

    
    tl = new Timeline()

    homeEnter = new Timeline()
    homeLeave = new Timeline()
    specsEnter = new Timeline()
    specsLeave = new Timeline()

    homeEnter.from headline.element, 1, headline.from, .75
    homeEnter.from tagline.element, 0.5, tagline.from, '-=0.5'

    homeLeave.to backgroundImage.element, 2, backgroundImage.to, 0
    homeLeave.to tagline.element, .5, tagline.fadeOut, 0

    specsEnter.to header.element, .5, header.up
    specsEnter.to 


    tl.to element, 0.1, className: '+=animation-sequence-home'
    tl.add 'before-home'
    tl.add homeEnter
    tl.add 'home'
    tl.add homeLeave
    tl.add 'after-home'
    tl.to element, 0.1, className: '-=animation-sequence-home'

    tl.to element, 0.1, className: '+=animation-sequence-specs'
    tl.add 'before-specs'
    tl.add specsEnter
    tl.add 'specs'
    tl.add specsLeave
    tl.add 'after-specs'
    # tl.to element, 0.1, className: '-=animation-sequence-specs'

    $scope.$on 'vertical-nav', (event, data) -> tl.tweenTo data.target
    tl.tweenTo 'home'

    window.tl = tl
