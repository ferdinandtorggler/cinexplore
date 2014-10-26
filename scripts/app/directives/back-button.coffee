angular.module('Cinexplore').directive 'backButton', (Overlays, Navigation) ->
  link: (scope) ->
    document.addEventListener 'backbutton', ->
      scope.$apply ->
        scope.$emit 'menu-close'
        Overlays.close()
        navigator.app.exitApp() unless Navigation.back()