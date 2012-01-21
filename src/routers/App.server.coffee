# Setup a closure variable whice records the time that the server was started.
# This is used to make sure static resources (css, js) have a different url
# when the code underneath them changes.
time = Date.now()

# On the server the send method is overridden to provide the path to actually
# send rendered pages to the browser. In addition to a rendered page, we also
# append a JSON versions of any models/collections to the page that were used.
# to construct it. While duplicative this allow us to easily re-attach those
# same views back onto the DOM client side.

router = routers.App.extend
    send: (view, options = {}) ->
        # Execute the main view.
        main = new view(options)

        # fetch model data first before we try to render
        main.prepare =>
            #main.render()
        
            # Send the page to the client
            # (including the templates.App "chrome")
            @res.send Bones.plugin.templates.App
                version: time
                title: @pageTitle(main)
                main: $(main.el).html()
                view: main.constructor.title
                options: JSON.stringify(options)
