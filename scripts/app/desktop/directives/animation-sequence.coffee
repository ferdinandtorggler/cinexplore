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
      in:
        opacity: 1
      up:
        top: '25%'

    tagline = 
      element: document.querySelector '.js-tagline'
      from:
        opacity: 0
        transform: 'translateY(30px)'
      fadeOut:
        opacity: 0

    specs =
      svg: document.querySelector '.js-specs-svg'
      out:
        transform: 'scale(0)'
        opacity: 0
        ease: Back.easeIn

    rating = 
      whole: document.querySelector '.js-rating-whole'
      part: document.querySelector '.js-rating-part'
      text: document.querySelector '.js-rating-text'
      from:
        transform: 'scale(0.5)'
        opacity: 0
        ease: Back.easeOut
      out:
        transform: 'scale(0)'
        ease: Back.easeIn

    duration = 
      part: document.querySelector '.js-duration-part'
      text: document.querySelector '.js-duration-container'
      to:
        opacity: 1
      out:
        opacity: 0
        transform: 'translateX(100px)'

    revenue = 
      whole: document.querySelector '.js-revenue-whole'
      part: document.querySelector '.js-revenue-part'
      text: document.querySelector '.js-revenue-container'
      to:
        opacity: 1
      out:
        opacity: 0
        transform: 'translateX(-100px)'

    plot =
      element: document.querySelector '.js-plot'
      from:
        opacity: 0
        transform: 'translateY(100px)'
      leave:
        opacity: 0
        transform: 'translateY(-50px)'


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
        plotEnter = new Timeline()
        plotLeave = new Timeline()
        galleryEnter = new Timeline()

        homeEnter.set header.element, header.in
        homeEnter.from headline.element, 1, headline.from, .75
        homeEnter.from tagline.element, .5, tagline.from, '-=0.5'

        homeLeave.to tagline.element, .25, tagline.fadeOut, 0

        specsEnter.to backgroundImage.element, 1, backgroundImage.to, 0
        specsEnter.to header.element, .5, header.up, 0
        specsEnter.from rating.text, .3, rating.from
        specsEnter.from rating.whole, .3, rating.from, '-=.3'
        specsEnter.to rating.part, 1, css: strokeDashoffset: rating.part.getAttribute 'data-fill-length'

        if $scope.movie.runtime
          specsEnter.to duration.part, 1, {css: strokeDashoffset: duration.part.getAttribute 'data-fill-length'}, '-=0.75'
          specsEnter.to duration.text, .4, duration.to, '-=0.25'

        if $scope.movie.budget and $scope.movie.revenue
          specsEnter.to revenue.whole, 1, {css: strokeDashoffset: revenue.whole.getAttribute 'data-fill-length'}, '-=0.5'
          specsEnter.to revenue.part, 1, {css: strokeDashoffset: revenue.part.getAttribute 'data-fill-length'}, '-=0.25'
          specsEnter.to revenue.text, .4, revenue.to, '-=0.25'

        specsLeave.to revenue.text, .3, revenue.out, 'specs'
        specsLeave.to duration.text, .3, duration.out, 'specs'
        specsLeave.to rating.text, .3, rating.out, 'specs'
        specsLeave.to specs.svg, .3, specs.out, 'specs+0.5'

        plotEnter.from plot.element, .5, plot.from
        plotLeave.to plot.element, .2, plot.leave

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

        tl.to element, 0.1, className: '+=animation-sequence-plot'
        tl.add 'before-plot'
        tl.add plotEnter
        tl.add 'plot'
        tl.add plotLeave
        tl.add 'after-plot'
        tl.to element, 0.1, className: '-=animation-sequence-plot'

        $scope.$on 'vertical-nav', (event, data) -> tl.tweenTo data.target
        tl.seek 'plot'

        window.tl = tl
