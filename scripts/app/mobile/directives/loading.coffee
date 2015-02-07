#
# Loading - Directive
#
# This directive is a placeholder for the loading animation. Text content is
# transcluded and will show up below the loading indicator.
#
#

angular.module('Cinexplore').directive 'loading', ->
  restrict: 'EA'
  templateUrl: 'loading.html'
  transclude: yes