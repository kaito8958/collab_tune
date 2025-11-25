class ApplicationController < ActionController::Base
  before_action :basic_auth, unless: -> { request.path == "/uptime" }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_unread_count, if: :user_signed_in?

  protected

  def uptime
    head :ok
  end

  def configure_permitted_parameters
    added_attrs = [
      :nickname,
      :introduction,
      :daw,
      :goal,
      :icon,
      { genres: [], performance_skills: [], production_skills: [], looking_for_skills: [], links: {} }
    ]

    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def set_unread_count
    @unread_count = Message
      .joins(:chat_room)
      .where(read: false)
      .where.not(user_id: current_user.id)
      .where("chat_rooms.requester_id = :id OR chat_rooms.receiver_id = :id", id: current_user.id)
      .count
  end
end