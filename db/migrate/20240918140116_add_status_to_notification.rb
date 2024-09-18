class AddStatusToNotification < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :status, :integer    
  end
end
