class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  after_create_commit :broadcast_message

  private

  def broadcast_message
    ActionCable.server.broadcast(
      "chat_room_#{chat_room.id}",
      {
        message_html: ApplicationController.render(
          partial: "messages/message",
          formats: [:html],
          locals: { message: self }
        ),
        user_id: user.id
      }
    )
  end
end
