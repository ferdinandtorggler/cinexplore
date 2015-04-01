#
#   Movies - Service
#
#   This service provides various methods to access the TheMovieDatabase API.
#
#

angular.module('Cinexplore').factory 'Movies', ($http) ->

  new class Movies

    TMDB_API_KEY = '42b3e655acbbce2f78acc89d06c154fc'
    API_BASE = 'https://api.themoviedb.org/'
    cache = {}

    fetch: (url, page) ->
      cacheKey = url + page
      return cache[cacheKey] if cache[cacheKey]

      params =
        api_key: TMDB_API_KEY
        callback: 'JSON_CALLBACK'
      params.page = page if page

      promise = $http.jsonp url, params: params
        
      cache[cacheKey] = promise
      return promise

    current:      (page) -> @fetch "#{API_BASE}3/movie/now_playing", page
    upcoming:     (page) -> @fetch "#{API_BASE}3/movie/upcoming", page
    popular:      (page) -> @fetch "#{API_BASE}3/movie/popular", page
    people:      (movie) -> @fetch "#{API_BASE}3/movie/#{movie}/credits"
    detail:         (id) -> @fetch "#{API_BASE}3/movie/#{id}?append_to_response=similar,images,credits,videos"
    videos:         (id) -> @fetch "#{API_BASE}3/movie/#{id}/videos"
    similar:        (id) -> @fetch "#{API_BASE}3/movie/#{id}/similar"
    images:         (id) -> @fetch "#{API_BASE}3/movie/#{id}/images"
    person:         (id) -> @fetch "#{API_BASE}3/person/#{id}?append_to_response=movie_credits,tagged_images"
    genres:              -> @fetch "#{API_BASE}3/genre/movie/list"
    genre:    (id, page) -> @fetch "#{API_BASE}3/genre/#{id}/movies", page

    search: (query, type = 'movie') ->
      query = encodeURIComponent query
      $http.jsonp "#{API_BASE}/3/search/#{type}", params:
        api_key: TMDB_API_KEY
        callback: 'JSON_CALLBACK'
        query: query