angular.module('Cinexplore').directive 'gainFocus', ($timeout) ->
  (scope, element) -> $timeout -> element[0].focus()