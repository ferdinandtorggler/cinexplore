#
#   Overlays - Service
#
#   This service keeps track of the currently open overlay
#   and is able to open or close an overlay.
#
#

class Overlays

  current = off

  open: (overlayName) -> current = overlayName
  close: -> current = off
  current: -> current

angular.module('Cinexplore').service 'Overlays', Overlays
