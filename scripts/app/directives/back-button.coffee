#
# Back Button - Directive
#
# This directive powers the native android back-button by using the 'backbutton' event
# emitted by Cordova.
# If the menu or an overlay is open, the back-button only closes those. Otherwise it
# navigates back in the view-history or closes the app when no history is left.
#
#

angular.module('Cinexplore').directive 'backButton', (Overlays, Navigation, Menu) ->
  link: (scope) ->
    document.addEventListener 'backbutton', ->
      scope.$apply ->
        if Menu.status() or Overlays.current()
          scope.$emit 'menu-close'
          Overlays.close()
        else
          navigator.app.exitApp() unless Navigation.back()