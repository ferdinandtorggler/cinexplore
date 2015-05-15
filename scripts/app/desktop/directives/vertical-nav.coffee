#
# Vertical Navigation - Directive
#
# Navigation component to control a timeline
# For navigating on click, set a [vn-target] attribute on child elements having an IDENTIFIER as value.
# On click, an event named 'vertical-nav' with the data {target: IDENTIFIER} will be emitted to parent scopes
#
#

angular.module('Cinexplore').directive 'verticalNav', ->
  restrict: 'EA'
  controller: ($scope, $element, $attrs) ->

    $scope.verticalNav = {}
    navItems = Array.prototype.splice.call $element[0].querySelectorAll('[vn-target]'), 0
    navTargets = navItems.map (item) -> item.getAttribute 'vn-target'

    $scope.verticalNav.active = navTargets[0]

    navTo = (target) ->
      return unless target
      $scope.$emit 'vertical-nav',
        current: $scope.verticalNav.active
        target: target
        reverse: (navTargets.indexOf target) < (navTargets.indexOf $scope.verticalNav.active)
      $scope.verticalNav.active = target

    nextTarget = -> 
      index = navTargets.indexOf $scope.verticalNav.active
      return false if index is navTargets.length - 1
      return navTargets[index + 1]

    prevTarget = -> 
      index = navTargets.indexOf $scope.verticalNav.active
      return false if index is 0
      return navTargets[index - 1]
      
    navItems.forEach (bullet) ->
      bullet.addEventListener 'click', ->
        target = bullet.getAttribute 'vn-target'
        $scope.$apply -> navTo target

    lock = off
    handle = (e) ->
      $scope.$apply ->
        unless lock

          if e.wheelDelta < 0
            navTo nextTarget()
          else 
            navTo prevTarget()


          setTimeout (-> lock = off), 500

        lock = on
      return false

    $scope.$on '$destroy', ->
      window.onmousewheel = -> {}

    window.onmousewheel = handle