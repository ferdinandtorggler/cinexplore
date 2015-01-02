#
# Offline - Directive
#
# This attribute directive handles native device connectivity events.
# When recieving connectivity status updates, the directive sets the 'offline' scope-property
# to true or false, depending on whether the device is connected to the internet.
#
#

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
