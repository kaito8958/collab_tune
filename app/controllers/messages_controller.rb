class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room, only: [:create]

  # メッセージ送信
  def create
    @message = @chat_room.messages.new(message_params)
    @message.user = current_user

    if @message.save
      # ✅ Modelのafter_create_commitで配信済みなのでここでは何もしない
      redirect_to @chat_room
    else
      @messages = @chat_room.messages.order(:created_at)
      flash.now[:alert] = 'メッセージを入力してください。'
      render 'chat_rooms/show', status: :unprocessable_entity
    end
  end

  # ✅ 既読にするAPI
  def mark_as_read
    message = Message.find(params[:id])

    # 自分以外が送ったメッセージのみ既読にする
    message.update(read: true) if message.user_id != current_user.id

    head :ok
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
