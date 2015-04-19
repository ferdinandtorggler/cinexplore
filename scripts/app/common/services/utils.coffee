#
#   Utils - Service
#
#   This service provides some helper methods.
#
#

angular.module('Cinexplore').factory 'Utils', ->

  new class Utils

    closest: (el, selector) ->
      matchesFn = undefined
      # find vendor prefix
      [
        'matches'
        'webkitMatchesSelector'
        'mozMatchesSelector'
        'msMatchesSelector'
        'oMatchesSelector'
      ].some (fn) ->
        if typeof document.body[fn] == 'function'
          matchesFn = fn
          return true
        false
      # traverse parents
      while el != null
        parent = el.parentElement
        if parent != null and parent[matchesFn](selector)
          return parent
        el = parent
      null