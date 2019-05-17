App.sk_progress_bar = App.cable.subscriptions.create "SkProgressBarChannel",
  connected: ->
# Called when the subscription is ready for use on the server

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    # Example: "data" variable => "message"=>"Almost done", "sk_process_id"=>{"jid"=>"ea5d1b09c0d8538bc1b571be"}, "progress_status"=>50
    progress_status = data.progress_status
    # jid - Sidekiq Job Id
    # $('.progress-bar') can be replaced to jid or any other business logic
    # Example: $("##{data.sk_process_id[:jid]}").attr('aria-valuenow', progress_status).css 'width', progress_status + '%'
    $(".progress-bar").attr('aria-valuenow', progress_status).css 'width', progress_status + '%'
    # Called when there's incoming data on the websocket for this channel