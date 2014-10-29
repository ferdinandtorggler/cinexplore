angular.module('Cinexplore').directive 'snap', ($rootScope, Menu) ->
  (scope, element) ->
    snapper = new Snap
      element: element[0]
      disable: 'right'
      transitionSpeed: .15
      slideIntent: 40
      addBodyClasses: no

    # use 'animated' callback since 'open' is not firing after dragging
    snapper.on 'animated', ->
      if snapper.state().state is 'left'
        Menu.open()
      else
        Menu.close()

    $rootScope.$on 'menu-open', -> snapper.open 'left'
    $rootScope.$on 'menu-close', -> snapper.close 'left'