angular.module('Cinexplore').directive 'backButton', (Overlays) ->
  link: (scope) ->
    document.addEventListener 'backbutton', ->
      scope.$apply ->
        scope.$emit 'menu-close'
        Overlays.close()