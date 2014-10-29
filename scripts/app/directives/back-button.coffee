angular.module('Cinexplore').directive 'backButton', (Overlays, Navigation, Menu) ->
  link: (scope) ->
    document.addEventListener 'backbutton', ->
      scope.$apply ->
        if Menu.status() or Overlays.current()
          scope.$emit 'menu-close'
          Overlays.close()
        else
          navigator.app.exitApp() unless Navigation.back()