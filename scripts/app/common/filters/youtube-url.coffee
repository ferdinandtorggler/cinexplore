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
      $sce.trustAsResourceUrl "http://www.youtube.com/embed/#{youtubeID}?autohide=1&modestbranding=1&enablejsapi=1"
    else
      ""