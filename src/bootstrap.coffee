jade  = require 'jade'
fs    = require 'fs'
path  = require 'path'
Bones = require 'Bones'

require.extensions['.jade'] = (module, filename) ->
    content = fs.readFileSync(filename, 'utf8')
    name = path.basename(filename).replace(/\..+$/, '')

    try
        module.exports = jade.compile(content)
        Bones.plugin.add(module.exports, filename)
    catch err
        # Show error message when template compilation failed.
        lines = err.message.split('\n')
        lines.splice(1, 0, '    in template ' + filename)
        err.message = lines.join('\n')
        throw err

    # The .register() method is called when the template is added to a server
    module.exports.register = (app) ->
        if (app.assets)
            app.assets.templates.push
                filename: filename
                content: 'var template = ' + jade.compile(content, client: true)
