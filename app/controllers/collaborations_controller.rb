class CollaborationsController < ApplicationController
  before_action :authenticate_user!

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

  private

  def collaboration_params
    params.require(:collaboration).permit(:receiver_id, :post_id, :message)
  end
end
