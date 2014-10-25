#
#   Movies - Service
#
#   This service provides various methods to access the TheMovieDatabase API.
#
#

class Movies

  TMDB_API_KEY = '42b3e655acbbce2f78acc89d06c154fc'
  API_BASE = 'https://api.themoviedb.org/'
  cache = {}

  constructor: (@$http) -> {}

  fetch: (url, shouldBeCached = yes) =>
    return cache[url] if cache[url]
    promise = @$http.jsonp url, params:
      api_key: TMDB_API_KEY
      callback: 'JSON_CALLBACK'
    cache[url] = promise if shouldBeCached
    return promise

  current:             -> @fetch "#{API_BASE}3/movie/now_playing"
  upcoming:            -> @fetch "#{API_BASE}3/movie/upcoming"
  popular:             -> @fetch "#{API_BASE}3/movie/popular"
  people:      (movie) -> @fetch "#{API_BASE}3/movie/#{movie}/credits"
  detail:         (id) -> @fetch "#{API_BASE}3/movie/#{id}?append_to_response=similar,images,credits,videos"
  videos:         (id) -> @fetch "#{API_BASE}3/movie/#{id}/videos"
  similar:        (id) -> @fetch "#{API_BASE}3/movie/#{id}/similar"
  images:         (id) -> @fetch "#{API_BASE}3/movie/#{id}/images"
  person:         (id) -> @fetch "#{API_BASE}3/person/#{id}?append_to_response=movie_credits,tagged_images"
  genres:              -> @fetch "#{API_BASE}3/genre/movie/list"
  genre:          (id) -> @fetch "#{API_BASE}3/genre/#{id}/movies"

  search: (query, type = 'movie') ->
    query = encodeURIComponent query
    @$http.jsonp "#{API_BASE}/3/search/#{type}", params:
      api_key: TMDB_API_KEY
      callback: 'JSON_CALLBACK'
      query: query


angular.module('Cinexplore').service 'Movies', Movies
