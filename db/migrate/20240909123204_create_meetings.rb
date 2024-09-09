class CreateMeetings < ActiveRecord::Migration[7.1]
  def change
    create_table :meetings do |t|
      t.string :title
      t.text :description
      t.integer :players_needed_min
      t.integer :players_needed_max
      t.string :location_type
      t.string :place_name
      t.string :place_address
      t.float :latitude
      t.float :longitude
      t.string :status
      t.string :level
      t.datetime :date
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
