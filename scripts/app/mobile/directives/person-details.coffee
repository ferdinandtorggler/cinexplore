#
# Person Details - Directive
#
# This directive contains the logic for the person detail view. The main purpose is
# fetching a person's information and rendering it to the page using the appropriate
# template.
#
#

angular.module('Cinexplore').directive 'personDetails', ($filter, Movies, View, Colors) ->
  scope: yes
  restrict: 'EA'
  templateUrl: 'person-details.html'
  link: (scope, elem, attrs) ->

    fetchInfos = (id) ->
      Colors.resetUIColor()
      scope.loading = yes
      Movies.person(id).success (person) ->
        scope.person = person
        scope.loading = no

        colorsPromise = Colors.fromImages person.movie_credits.cast.map (item) -> $filter('imagePath')(item.poster_path, 92)
        colorsPromise.success (res) -> scope.coverColors = res.colors

    scope.$watch View.params, (params) ->
      fetchInfos params.id