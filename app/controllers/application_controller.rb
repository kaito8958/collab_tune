class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_unread_count, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :profile, :instrument, :genre])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :profile, :instrument, :genre])
  end

  private

  def set_unread_count
    @unread_count = Message
      .joins(:chat_room)
      .where(read: false)
      .where.not(user_id: current_user.id)
      .where("chat_rooms.requester_id = :id OR chat_rooms.receiver_id = :id", id: current_user.id)
      .count
  end
end