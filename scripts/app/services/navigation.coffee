#
#   Navigation - Service
#
#   This service holds information about the currently
#   open view and the history in order to provide the
#   back-button functionality.
#  
#

class Navigation

  stack = [{view: 'list', data: null}]

  current: -> stack[stack.length - 1]
  back: -> stack.pop()
  navigate: (name, data) ->
    stack.push
        view: name
        data: data


angular.module('Cinexplore').service 'Navigation', Navigation