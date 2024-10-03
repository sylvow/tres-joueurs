class AddCategoryToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :category, :string
  end
end
