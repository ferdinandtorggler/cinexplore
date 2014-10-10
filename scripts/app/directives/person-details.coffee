angular.module('Cinexplore').directive 'personDetails', (Movies) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'person-details.html'
  link: (scope, elem, attrs) ->

    fetchInfos = ->
      Movies.person(attrs.personId).success (person) ->
        scope.person = person
      Movies.moviesOfPerson(attrs.personId).success (movies) ->
        scope.movies = movies.cast
      Movies.imagesOfPerson(attrs.personId).success (images) ->
        scope.images = images.results

    attrs.$observe 'personId', fetchInfos