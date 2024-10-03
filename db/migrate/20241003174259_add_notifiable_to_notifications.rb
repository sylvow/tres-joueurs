class AddNotifiableToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_reference :notifications, :notifiable, polymorphic: true, null: false
  end
end
