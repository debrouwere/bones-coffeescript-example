router = routers.App.extend
    routes:
        '/': 'home'
        '/profile/:name/': 'profile'

    home: ->
        @send views.Home

    profile: (name) ->
        @send views.Profile, {name: name}
