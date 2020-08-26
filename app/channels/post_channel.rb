class PostChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post_channel"
    # stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
