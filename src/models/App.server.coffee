# Server-side content fetching using Backbone
# Only tested for GET requests

request = require 'request'

noop = ->

methods =
    create: "post"
    read: "get"
    update: "put"
    delete: "del"

get_url = (object) ->
    if object.url instanceof Function
        object.url()
    else if typeof object.url is 'string'
        return object.url

Backbone.sync = (method, model, options) ->
    params =
        method: methods[method]
        url: get_url(model)

    request params, (error, response, body) ->
        content = JSON.parse body
    
        if !error and response.statusCode < 300
            options.success content, response
        else
            options.error error, response
