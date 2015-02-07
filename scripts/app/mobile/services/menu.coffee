#
#   Menu - Service
#
#   This service keeps track of the menu state.
#
#

class Menu

  isOpen = no

  open: -> isOpen = yes
  close: -> isOpen = no
  status: -> isOpen

angular.module('Cinexplore').service 'Menu', Menu
