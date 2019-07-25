App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    toastr.info("Hi there, you have a new message", "Notification") if data.mention
    if (data.message)
      $("#message-container").append data.message
      scroll_bottom()
