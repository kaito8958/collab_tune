class CollaborationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @sent_collaborations = current_user.sent_collaborations.includes(:receiver, :post)
    @received_collaborations = current_user.received_collaborations.includes(:requester, :post)
  end


  def create
    @collaboration = current_user.sent_collaborations.build(collaboration_params)
    @collaboration.status = 'pending'

    if @collaboration.receiver_id == current_user.id
      redirect_to posts_path, alert: "自分の投稿には申請できません。"
      return
    end

    if @collaboration.save
      redirect_to @collaboration.post, notice: 'コラボ申請を送信しました。'
    else
      redirect_to @collaboration.post, alert: 'コラボ申請に失敗しました。'
    end
  end

def update
  @collaboration = Collaboration.find(params[:id])

  if params[:status].in?(%w[accepted rejected])
    @collaboration.update(status: params[:status])

    if @collaboration.status == "accepted"
      room = ChatRoom.create!(
        collaboration_id: @collaboration.id,
        requester_id: @collaboration.requester_id,
        receiver_id: @collaboration.receiver_id
      )
      redirect_to chat_room_path(room), notice: "コラボを承認しました。チャットを開始しましょう。"
      return
    else
      redirect_to collaborations_path, alert: "コラボ申請を拒否しました。"
      return
    end
  else
    redirect_to collaborations_path, alert: "無効な操作です。"
    return
  end
end




  private

  def collaboration_params
    params.require(:collaboration).permit(:receiver_id, :post_id, :message)
  end
end
