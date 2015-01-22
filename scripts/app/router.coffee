angular.module('Cinexplore').config ($routeProvider) ->

  routes = [

    {
      route: '/movies/category/:category'
      data:
        view: 'list.category'
    },
    {
      route: '/movies/genre/:genreId'
      data:
        view: 'list.genre'
    },
    {
      route: '/movie/:id'
      data:
        view: 'detail.movie'
    },
    {
      route: '/search'
      data:
        view: 'search'
    },
    {
      route: '/movie/:id'
      data:
        view: 'detail.movie'
    },
    {
      route: '/person/:id'
      data:
        view: 'detail.person'
    },
    {
      route: '/movies/:id/images'
      data:
        view: 'detail.movies'
        overlay: 'images'
    },
    {
      route: '/person/:id/images'
      data:
        view: 'detail.person'
        overlay: 'images'
    },
    {
      route: '/about'
      data:
        view: 'custom.about'
    }

  ]

  routes.forEach (routeConfig) -> $routeProvider.when routeConfig.route, routeConfig.data
