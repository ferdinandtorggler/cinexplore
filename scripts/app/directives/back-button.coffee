angular.module('Cinexplore').directive 'backButton', () ->
    link: ->
        document.addEventListener 'backbutton', ->
            console.log 'back pressed'