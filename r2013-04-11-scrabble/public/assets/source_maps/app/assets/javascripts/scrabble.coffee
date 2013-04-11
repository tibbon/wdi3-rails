window.app =
  selected_cell: null
  selected_channel: null
  pusher: null
  ready: ->
    $('#channels').on('click', '.channel', app.select_cell)
    app.pusher = new Pusher('3a852337fd2551e668fc')
  select_cell: ->
    app.selected_cell.removeClass('selected_cell') if app.selected_cell

    if app.selected_cell && (app.selected_cell[0] == this)
      app.selected_cell = null
    else
      app.selected_cell = $(this)
      app.selected_cell.addClass('selected_cell')
      app.select_channel(app.selected_cell.text())
  select_channel: (name) ->
    app.pusher.unsubscribe(app.selected_channel) if app.selected_channel
    app.pusher.subscribe(name)
    app.selected_channel = name
    app.bind_events()
  bind_events: ->
    channel = app.pusher.channels.channels[app.selected_channel]
    channel.bind('chat', app.chat)
  chat: (data) ->
    console.log(data)

$(document).ready(app.ready)
