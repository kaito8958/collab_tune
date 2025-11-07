class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  after_create_commit :broadcast_message
  after_create_commit :broadcast_notification  

  scope :unread_for, ->(user) {
    where(read: false)
      .joins(:chat_room)
      .where("chat_rooms.requester_id = :id OR chat_rooms.receiver_id = :id", id: user.id)
      .where.not(user_id: user.id)
  }

  private

  def broadcast_message
    ActionCable.server.broadcast(
      "chat_room_#{chat_room.id}",
      {
        message_html: ApplicationController.render(
          partial: "messages/message",
          formats: [:html],
          locals: { message: self, current_user: user }
        ),
        message_id: id, # ✅ 追加：既読APIで使用
        user_id: user.id
      }
    )
  end

  def broadcast_notification
    recipient_id =
      if chat_room.requester_id == user_id
        chat_room.receiver_id
      else
        chat_room.requester_id
      end

    ActionCable.server.broadcast(
      "notifications_#{recipient_id}",
      {
        unread_count: Message.unread_for(User.find(recipient_id)).count
      }
    )
  end
end
