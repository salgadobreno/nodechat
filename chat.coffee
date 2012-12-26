@socket = io.connect()

$(document).ready( ->
  $('#chat_form').submit((e) ->
    e.preventDefault()
    message = $('#chat_input').val()
    @socket.emit('messages', message)
    )
  )
