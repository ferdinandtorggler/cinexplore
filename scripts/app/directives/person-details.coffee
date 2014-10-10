angular.module('Cinexplore').directive 'personDetails', (Movies) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'person-details.html'
  link: (scope, elem, attrs) ->

    fetchInfos = ->
      Movies.person(attrs.personId).success (person) ->
        scope.person = person

    attrs.$observe 'personId', fetchInfos