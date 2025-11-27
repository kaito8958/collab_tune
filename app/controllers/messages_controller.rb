class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room, only: [:create, :poll]

  # メッセージ送信
  def create
    @message = @chat_room.messages.new(message_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        # ← ★ Ajax用：部分テンプレートをHTMLとして返す
        format.json do
          html = render_to_string(
            partial: 'messages/message',
            locals: { message: @message, sender_id: current_user.id },
            formats: [:html]
          )
          render json: { html: html, message_id: @message.id }
        end

        # ← ★ 通常遷移（ActionCable 前提のまま残す）
        format.html do
          redirect_to @chat_room
        end
      end

    else
      # 失敗時（通常の画面遷移時のみ使用）
      @messages = @chat_room.messages.order(:created_at)

      respond_to do |format|
        format.json do
          render json: { error: 'メッセージを入力してください。' },
                 status: :unprocessable_entity
        end

        format.html do
          flash.now[:alert] = 'メッセージを入力してください。'
          render 'chat_rooms/show', status: :unprocessable_entity
        end
      end
    end
  end

  # 既読にするAPI
  def mark_as_read
    message = Message.find(params[:id])
    message.update(read: true) if message.user_id != current_user.id
    head :ok
  end

  def poll
    last_id = params[:last_id].to_i

    new_messages = @chat_room.messages
                             .where('id > ?', last_id)
                             .includes(:user)

    html = new_messages.map do |m|
      render_to_string(
        partial: 'messages/message',
        locals: { message: m, sender_id: current_user.id },
        formats: [:html]
      )
    end.join

    render json: {
      html: html,
      last_id: new_messages.last&.id || last_id
    }
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
