view = Backbone.View.extend
    # Err, I'll probably have to revisit this, 
    # but for now it works.
    _ensureElement: ->
        if Bones.server
            Backbone.View::_ensureElement.apply @, arguments
        else
            @el = $('body')

    initialize: (options) ->
        unless Bones.server or options.el
            @el = $('#main')

    # load a page or refresh a page element
    render: ->
        rendering = templates[@template] @options
        $(@el).empty().append rendering
        return this
