class RemoveRequestReferencesColumnFromNotifications < ActiveRecord::Migration[7.1]
  def change
    remove_reference :notifications, :request, index: true, foreign_key: true
  end
end
