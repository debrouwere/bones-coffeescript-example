router = routers.App.extend
    routes:
        '/': 'home'
        '/loaves/:slug/': 'detail'

    home: ->
        @send views.Home

    detail: (slug) ->
        @send views.Bread, {slug: slug}
