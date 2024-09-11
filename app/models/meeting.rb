class Meeting < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :requests
  has_many :messages

  accepts_nested_attributes_for :game

  geocoded_by :place_address
  after_validation :geocode, if: :will_save_change_to_place_address?

  validates :title, :game_id, :players_needed_min, :location_type, :date, :level, presence: true
end
