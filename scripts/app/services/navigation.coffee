#
#   Navigation - Service
#
#   This service holds information about the currently
#   open view and the history in order to provide the
#   back-button functionality.
#  
#

class Navigation

  stack = [{view: 'list', data: {category: 'popular'}}]

  findLastListView = ->
    listViews = stack.filter (entry) -> entry.view is 'list'
    listViews[listViews.length - 1]

  current: -> stack[stack.length - 1]
  toList: -> stack.push findLastListView()

  back: ->
    return false if stack.length is 1
    stack.pop()

  navigate: (name, data, clearHistory) ->
    stack.length = 0 if clearHistory
    stack.push
        view: name
        data: data
    
angular.module('Cinexplore').service 'Navigation', Navigation