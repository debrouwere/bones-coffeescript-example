view = views.App.extend
    id: 'main'
    template: 'Bread'
    pageTitle: 'A type of bread'

    prepare: (callback) ->
        self = @

        new models.Breads().fetch success: (breads) ->
            self.options.bread = breads.find (bread) ->
                bread.get('slug') is self.options.slug

            callback()
