model = Backbone.Model.extend
    initialize: (options) ->
        @path = "/loaves/#{options.slug}/"
