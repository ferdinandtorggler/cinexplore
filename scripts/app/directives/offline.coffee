angular.module('Cinexplore').directive 'offline', (Overlays) ->
    link: (scope) ->

        offline = ->
            Overlays.close()
            scope.$emit 'menu-close'
            scope.$apply -> scope.offline = yes

        online = ->
            scope.$apply -> scope.offline = no

        document.addEventListener 'offline', offline, no
        document.addEventListener 'online', online, no
