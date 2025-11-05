class CollaborationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @collaboration = Collaboration.new(collaboration_params)
    @collaboration.requester = current_user
    @collaboration.status = 'pending'

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
