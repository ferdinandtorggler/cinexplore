angular.module('Cinexplore').directive 'swiper', ($parse, $timeout) ->
  restrict: 'EA'
  link: (scope, element, attrs) ->

    slideWidth = false
    indicator = document.querySelector '.tabs__indicator'
    tabs = document.querySelectorAll 'tabs .tabs__tab'
    offset = 0
    direction = 0

    # The transition property needs to be toggled, because updates while touching
    # have to happen as soon as the callback fires in order to avoid lag.
    transitionOff = -> indicator.classList.remove 'tabs__indicator--transitioning'
    transitionOn = -> indicator.classList.add 'tabs__indicator--transitioning'

    transitionToTab = ->
      transitionOn()
      indicator.style.transform = 'translateX(' + tabs[scope.swiper.activeIndex].offsetLeft + 'px)'
      indicator.style.width = tabs[scope.swiper.activeIndex].offsetWidth + 'px'
      $timeout transitionOff, 2500
      offset = 0
      direction = 0

    synchronizeTabs = (swiper) ->
      transitionOff()
      index = swiper.activeIndex

      if direction
        percentage = swiper.positions.current % slideWidth / slideWidth
        if direction is 1
          indicator.style.transform = 'translateX(' + (tabs[index].offsetLeft + tabs[index].offsetWidth * -percentage) + 'px)'
          indicator.style.width = (tabs[index].offsetWidth + (tabs[index + direction].offsetWidth - tabs[index].offsetWidth) * -percentage) + 'px'
        else if direction is -1
          indicator.style.transform = 'translateX(' + (tabs[index].offsetLeft - tabs[index-1].offsetWidth * (1+percentage)) + 'px)'
          indicator.style.width = (tabs[index].offsetWidth + (tabs[index + direction].offsetWidth - tabs[index].offsetWidth) * (1+percentage)) + 'px'
      
      # If direction was not determined yet, it is calculated from saved offset of the last callback
      else if offset
        direction = if swiper.positions.current < offset then 1 else -1
        
      # If we didn't save an offset, this is the first touchmove callback and an offset is saved.
      else
        offset = swiper.positions.current



    createSlider = ->
      options = $parse(attrs.sOptions)() or {}

      options.pagination = document.querySelector 'tabs .tabs__container'
      options.paginationClickable = true
      options.paginationElementClass = 'tabs__tab'
      options.paginationActiveClass = 'tabs__tab--active'
      options.paginationVisibleClass = ''
      options.createPagination = false

      options.onTouchMove = synchronizeTabs
      options.onSlideChangeStart = transitionToTab
      options.onSlideReset = transitionToTab

      scope.swiper = new Swiper element[0], options
      slideWidth = scope.swiper.getFirstSlide().offsetWidth

    $timeout createSlider, 100