angular.module('Cinexplore').directive 'ripple', ($window, $timeout) ->

  inkClass = 'ripple__ink'

  makeContainer = (element) ->
    position = $window.getComputedStyle(element).position
    element.style.position = 'relative' if position is 'static'

  (scope, elem, attrs) ->

    elem = elem[0]
    makeContainer elem
    elem.addEventListener 'click', (e) ->

      unless elem.querySelector ".#{inkClass}"
        elem.insertAdjacentHTML 'afterBegin', "<span class=#{inkClass}></span>"
            
      ink = elem.querySelector ".#{inkClass}"
      ink.classList.remove 'animate'
        
      unless ink.innerHeight or ink.innerWidth
        d = Math.max elem.offsetWidth, elem.offsetHeight
        ink.style.height = "#{d}px"
        ink.style.width = "#{d}px"
      
      x = e.pageX - elem.getBoundingClientRect().left - ink.offsetWidth / 2
      y = e.pageY - elem.getBoundingClientRect().top - ink.offsetHeight / 2
      
      ink.style.top = "#{y}px"
      ink.style.left = "#{x}px"
      ink.classList.add 'animate'

