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
      Movies.moviesOfPerson(attrs.personId).success (movies) ->
        scope.movies = movies.cast
        scope.loading = no
      Movies.imagesOfPerson(attrs.personId).success (images) ->
        scope.images = images.results
        scope.loading = no

    attrs.$observe 'personId', fetchInfos