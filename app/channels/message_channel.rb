class MessageChannel < ApplicationCable::Channel
  def subscribed
    # クライアントがこのチャットルームに入る時に呼ばれる
    stream_from "chat_room_#{params[:chat_room_id]}"
  end

  def unsubscribed
  end
end
