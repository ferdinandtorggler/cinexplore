#
#   YouTube URL - Filter
#
#   This filter converts a YouTube ID into an embed-link which can be used
#   as the source of an iframe.
#
#

angular.module('Cinexplore').filter 'youtubeUrl', ($sce) ->

  (youtubeID) ->
    if youtubeID
      $sce.trustAsResourceUrl "http://www.youtube.com/embed/#{youtubeID}?autohide=1&rel=0&modestbranding=1&enablejsapi=1&showinfo=0&controls=0&iv_load_policy=3&autoplay=1"
    else
      ""