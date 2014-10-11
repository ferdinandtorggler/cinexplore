angular.module('Cinexplore').directive 'snap', ($rootScope) ->
  (scope, element) ->
    snapper = new Snap
      element: element[0]
      disable: 'right'
      transitionSpeed: .15
      slideIntent: 40
      addBodyClasses: yes

    $rootScope.$on 'menu-open', -> snapper.open 'left'
    $rootScope.$on 'menu-close', -> snapper.close 'left'