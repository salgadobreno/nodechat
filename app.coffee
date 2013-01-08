@express = require 'express'
@socket = require 'socket.io'
@http = require 'http'

@app = @express()
@server = @http.createServer @app
@io = @socket.listen @server

@app.use('/public', @express.static(__dirname + '/public'))

@server.listen(3000)

@app.get '/', (req, response) ->
  response.render(__dirname + '/index.ejs')

@io.sockets.on 'connection', (client) ->
  console.log 'Client connected.'

  client.on('join', (name) ->
    console.log("client nick:" + name)
    client.set('nickname', name)
  )

  client.on('messages', (data) ->
    client.get('nickname', (err, name) ->
      client.broadcast.emit('messages', name + ': ' + data)
    )
  )

