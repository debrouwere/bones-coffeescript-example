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
    send: (view, context = {}) ->
        # Execute the main view.
        main = new view(context)
        main.render()

        # Provide all models with the data that we'll use to prop them back up
        # on the browser.
        data = _.map context, (v, k) ->
            # Any options that is a model or collection will have its title
            # declared. Use this to re-hydrate it.
            model = v.constructor.title
            key = JSON.stringify(k)
            value = JSON.stringify(context[k])
            
            if model?
                return "#{key}: new models.#{model}(#{value})"
            else
                return "#{key}: #{value}"

        serialized_data = '{' + data.join(',') + '}'

        # Finally send the page to the client.
        @res.send Bones.plugin.templates.App
            version: time
            title: @pageTitle(main)
            main: $(main.el).html()
            view: main.constructor.title
            options: serialized_data
