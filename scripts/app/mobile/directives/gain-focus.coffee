#
# Gain Focus - Directive
#
# This attribute directive gives the focus to its element immediately
#
#

angular.module('Cinexplore').directive 'gainFocus', ($timeout) ->
  (scope, element) -> $timeout -> element[0].focus()