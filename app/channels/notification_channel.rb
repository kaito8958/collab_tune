class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{current_user.id}"
  end



  def unsubscribed
    current_user.update(current_room_id: data["room_id"])
  end

  def update_current_room(data)
    current_user.update(current_room_id: data["room_id"])
    Rails.logger.info "💡 User #{current_user.id} entered room #{data["room_id"]}"
  end
end
