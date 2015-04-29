angular.module('Cinexplore').directive 'animationSequence', ($timeout, Timeline) ->

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
        top: '25%'

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
      text: document.querySelector '.js-rating-text'
      from:
        transform: 'scale(0.5)'
        opacity: 0
        ease: Back.easeOut

    duration = 
      part: document.querySelector '.js-duration-part'
      text: document.querySelector '.js-duration-container'
      from:
        opacity: 0

    revenue = 
      whole: document.querySelector '.js-revenue-whole'
      part: document.querySelector '.js-revenue-part'
      text: document.querySelector '.js-revenue-container'
      from:
        opacity: 0

    preparePath = (path, fillAmount = 1, reverse) ->
      length = path.getTotalLength()
      # Clear any previous transition
      path.style.transition = path.style.WebkitTransition = 'none'
      # Set up the starting positions
      path.style.strokeDasharray = length + ' ' + length
      path.style.strokeDashoffset = length

      reverse = if reverse then -1 else 1
      path.setAttribute 'data-fill-length', length - length * parseFloat fillAmount * reverse
      path.getBoundingClientRect() # Trigger a layout

    $scope.$watch 'loaded', (loaded) ->
      return unless loaded

      $timeout -> # once the movie is loaded we need to render it

        preparePath rating.part, $scope.movie.vote_average / 10
        preparePath duration.part, if $scope.movie.runtime > 180 then 1 else $scope.movie.runtime / 180
        preparePath revenue.part, 1 - $scope.movie.budget / $scope.movie.revenue, yes
        preparePath revenue.whole, 1, yes

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
        specsEnter.from rating.text, .3, rating.from
        specsEnter.from rating.whole, .3, rating.from, '-=.2'
        specsEnter.to rating.part, 1, css: strokeDashoffset: rating.part.getAttribute 'data-fill-length'
        if $scope.movie.runtime
          specsEnter.to duration.part, 1, {css: strokeDashoffset: duration.part.getAttribute 'data-fill-length'}, '-=0.75'
          specsEnter.from duration.text, .4, duration.from, '-=0.25'
        if $scope.movie.budget and $scope.movie.revenue
          specsEnter.to revenue.whole, 1, {css: strokeDashoffset: revenue.whole.getAttribute 'data-fill-length'}, '-=0.5'
          specsEnter.to revenue.part, 1, {css: strokeDashoffset: revenue.part.getAttribute 'data-fill-length'}, '-=0.25'
          specsEnter.from revenue.text, .4, revenue.from, '-=0.25'


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
        tl.to element, 0.1, className: '-=animation-sequence-specs'

        $scope.$on 'vertical-nav', (event, data) -> tl.tweenTo data.target
        tl.tweenTo 'home'

        window.tl = tl
