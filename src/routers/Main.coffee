router = routers.App.extend
    routes:
        '/': 'home'
        '/loaves/:type/': 'detail'

    home: ->
        @send views.Home

    detail: (type) ->
        @send views.Bread, {type: type}
