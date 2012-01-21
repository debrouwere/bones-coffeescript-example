view = views.App.extend
    id: 'main'
    template: 'Home'
    pageTitle: 'Homepage'

    prepare: (callback) ->
        new models.Breads().fetch success: (breads) =>
            @options.breads = breads
            callback()
