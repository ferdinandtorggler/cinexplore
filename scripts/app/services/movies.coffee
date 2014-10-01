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

    inTheaters:       () -> @fetch "#{API_BASE}3/movie/now_playing"
    upcoming:         () -> @fetch "#{API_BASE}3/movie/upcoming"
    popular:          () -> @fetch "#{API_BASE}3/movie/popular"
    topRated:         () -> @fetch "#{API_BASE}3/movie/top_rated"
    people:      (movie) -> @fetch "#{API_BASE}3/movie/#{movie}/credits"
    detail:         (id) -> @fetch "#{API_BASE}3/movie/#{id}"
    videos:         (id) -> @fetch "#{API_BASE}3/movie/#{id}/videos"
    person:         (id) -> @fetch "#{API_BASE}3/person/#{id}"
    genres:           () -> @fetch "#{API_BASE}3/genre/movie/list"
    byGenre:        (id) -> @fetch "#{API_BASE}3/genre/#{id}/movies"
    moviesOfPerson: (id) -> @fetch "#{API_BASE}3/person/#{id}/movie_credits"

    search: (query) ->
        query = encodeURIComponent query
        @$http.jsonp "#{API_BASE}/3/search/movie", params:
            api_key: TMDB_API_KEY
            callback: 'JSON_CALLBACK'
            query: query


angular.module('Cinexplore').service 'Movies', Movies
