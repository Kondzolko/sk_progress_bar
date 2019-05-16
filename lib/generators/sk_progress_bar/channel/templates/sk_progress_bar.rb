class SkProgressBarChannel < ApplicationCable::Channel
  def subscribed
    stream_from "sk_progress_bar_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end