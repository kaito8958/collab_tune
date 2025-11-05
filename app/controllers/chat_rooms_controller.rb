class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  # 自分に関係するチャットルーム一覧
  def index
    @chat_rooms = ChatRoom.where("requester_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  # 特定チャットルームを表示（メッセージ一覧）
  def show
    @chat_room = ChatRoom.find(params[:id])
    @messages = @chat_room.messages.order(:created_at)
    @message = Message.new
  end

  # 手動でルームを作る（テスト用）
  def create
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      redirect_to @chat_room, notice: "チャットルームを作成しました。"
    else
      render :index, alert: "作成に失敗しました。"
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:collaboration_id, :requester_id, :receiver_id)
  end
end
