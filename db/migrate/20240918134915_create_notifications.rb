class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :type
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
