Bones.initialize (models, views, routers, templates) ->
    window.app =
        models: models
        views: views
        routers: routers
        templates: templates

    main_router = new routers.Main()
    app.navigate = main_router.navigate

    state = Backbone.history.start
        root: ''            # empty so we can have all our routes start with '/'
        pushState: true     # HTML5 history support

    # All navigation that is relative should be passed through the navigate
    # method, to be processed by the router.  If the link has a data-bypass
    # attribute, bypass the delegation completely.

    # Change to this once Bones updates to the new jQuery version: 
    # $(document).on "click", "a:not([data-bypass])", (event) ->
    $(document).delegate "a:not([data-bypass])", "click", (event) ->
        # Get the anchor href and protocol
        url = event.target.getAttribute('href', 2)
        external_link = url.slice(0, 4) is 'http'
        unless external_link
            app.navigate url, true
            event.preventDefault()
