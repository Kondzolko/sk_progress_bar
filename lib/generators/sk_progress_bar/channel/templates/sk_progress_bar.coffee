App.sk_progress_bar = App.cable.subscriptions.create "SkProgressBarChannel",
  connected: ->
# Called when the subscription is ready for use on the server

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
# Example: "data" variable => "message"=>"Almost done", "sk_process_id"=>"ea5d1b09c0d8538bc1b571be", "progress_status"=>50
    progress_status = data.progress_status
    # sk_process_id - Sidekiq Job Id
    # $('.progress-bar') can be replaced to sk_process_id or any other business logic

    # Example: $("##{data.sk_process_id}").attr('aria-valuenow', progress_status).css 'width', progress_status + '%'
#    $(".progress-bar").attr('aria-valuenow', progress_status).css 'width', progress_status + '%'

    # For add percentage inside in progress bar
#    $(".progress-bar").text(progress_status + '%')
    # Called when there's incoming data on the websocket for this channel

    document.getElementById("sk_progress_bar").max = progress_status
    # Update progress bar without jquery and bootstrap

    document.getElementById("sk_progress_bar").style.width = progress_status + '%'
    # Update bootstrap progress bar without jquery