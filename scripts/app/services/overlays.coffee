#
#   Overlays - Service
#
#   This service keeps track of the currently open overlay
#   and is able to open or close an overlay.
#
#

class Overlays

  current = off
  currentData = off

  open: (name, data) ->
    current = name
    currentData = data
    
  close: -> current = off
  current: -> current
  currentData: -> currentData

angular.module('Cinexplore').service 'Overlays', Overlays
