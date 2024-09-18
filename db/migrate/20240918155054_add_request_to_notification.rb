class AddRequestToNotification < ActiveRecord::Migration[7.1]
  def change
    add_reference :notifications, :request, null: false, foreign_key: true
    add_column :notifications, :type, :string
  end
end
