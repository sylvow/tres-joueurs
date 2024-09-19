class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :notif
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :phone_number, :date_of_birth, :profile_picture])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username, :phone_number, :date_of_birth, :profile_picture])
  end

  def notif
    @notifications = Notification.where(status: Notification.statuses[:unread]).where(request: Request.where(user: current_user))
  end
end
