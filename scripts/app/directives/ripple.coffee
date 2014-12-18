angular.module('Cinexplore').directive 'ripple', ($window, $timeout) ->
  (scope, elem, attrs) ->

    elem = elem[0]
    elem.addEventListener 'click', (e) ->

      unless elem.querySelector '.ink'
        elem.insertAdjacentHTML 'afterBegin', '<span class="ink"></span>'
            
      ink = elem.querySelector '.ink'
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

