class AddContentToNotification < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :content, :string
  end
end
