class NotificationsController < ApplicationController
  def index
    req_approved = Notification.where(notifiable: Request.where(user: current_user))
    req_received = Notification.where(notifiable: Meeting.where(user: current_user))
    new_message = Notification.where(notifiable: Message.where(meeting: Meeting.where(user: current_user)))
    @all_notif = req_approved + req_received + new_message
    @sorted_notif = @all_notif.to_a.sort_by { |notif| Time.now - Time.parse(notif.created_at.to_s) }
  end
end
