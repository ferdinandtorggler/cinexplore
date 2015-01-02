#
# Person Details - Directive
#
# This directive contains the logic for the person detail view. The main purpose is
# fetching a person's information and rendering it to the page using the appropriate
# template.
#
#

angular.module('Cinexplore').directive 'personDetails', (Movies) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'person-details.html'
  link: (scope, elem, attrs) ->

    fetchInfos = ->
      scope.loading = yes
      Movies.person(attrs.personId).success (person) ->
        scope.person = person
        scope.loading = no

    attrs.$observe 'personId', fetchInfos