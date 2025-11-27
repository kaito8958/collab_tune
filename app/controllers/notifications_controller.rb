class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def poll
    # current_user にとって「未読」のメッセージ数を数える

    unread_count = Message
                   .joins(:chat_room)
                   .where(read: false)
                   .where.not(user_id: current_user.id) # 自分が送ったメッセージは除外
                   .where(
                     'chat_rooms.requester_id = :uid OR chat_rooms.receiver_id = :uid',
                     uid: current_user.id
                   )
                   .count

    render json: { unread_count: unread_count }
  end
end
