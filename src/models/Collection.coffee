model = Backbone.Collection.extend
    # fetch content from external APIs through a relay when fetching client-side, 
    # to avoid AJAX cross-domain limitations
    url: ->
        if Bones.server
            @endpoint
        else
            "/api/#{@model.title}"
