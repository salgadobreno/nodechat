@socket = io.connect()

@socket.on('connect', (data) ->
  $('#status').html('Connected to chattr')
  nickname = prompt 'What is your nickname?'

  socket.emit('join', nickname)
)

@socket.on('messages', (data) ->
  insertMessage(data)
  )

$(document).ready( ->
  $('#chat_form').submit((e) ->
    e.preventDefault()
    message = $('#chat_input').val()
    socket.emit('messages', message)
    insertMessage(message)
    )
  )


class insertMessage
  constructor: (data) ->
    $("#messages").append("<p>"+data+"</p>")
