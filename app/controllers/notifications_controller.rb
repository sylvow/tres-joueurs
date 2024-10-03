class NotificationsController < ApplicationController
  def index
    @notif_req_approved = Notification.where(category: 'approved-request').where(status: Notification.statuses[:unread]).where(request: Request.where(user: current_user))
    @notif_req_received = Notification.where(category: 'pending-request').where(request: Request.statuses[:interested]).where(request: Request.where(meeting: Meeting.where(user: current_user)))
    @now = Time.now
    @sorted_notif_req_approved = @notif_req_approved.to_a.sort_by { |notif| @now - (Time.parse(notif.created_at.to_s)) }
  end
end
