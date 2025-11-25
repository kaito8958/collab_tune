class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{current_user.id}"
    Rails.logger.info "📡 Subscribed to notifications_#{current_user.id}"
  end

  def unsubscribed
    Rails.logger.info "🔌 Unsubscribed from notifications_#{current_user.id}"
  end

  def update_current_room(data)
    return unless data['room_id'].present?

    current_user.update(current_room_id: data['room_id'])
    Rails.logger.info "💡 User #{current_user.id} entered room #{data['room_id']}"
  end
end
