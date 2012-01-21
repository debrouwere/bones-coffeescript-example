router = Backbone.Router.extend
    # helper to assemble HTML page titles
    pageTitle: (view) ->
        title =  'A simple Bones example app'

        if view.pageTitle?
            return view.pageTitle + ' | ' + title
        else
            return title

    send: (view, options = {}) ->
        view = new view(options)

        # Set the page title.
        document.title = @pageTitle(view)
        # Populate the #page div with the main view.
        view.prepare ->
            view.render()

    # Generic error handling for our Router.
    error: (error) ->
        if _.isArray(error) then error = error.shift()
        @send views.Error, error: error
