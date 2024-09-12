class Meeting < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :requests
  has_many :messages

  accepts_nested_attributes_for :game

  enum status: { available: "Disponible", full: "Plein", ongoing: "En cours", cancelled: "Annulé", finished: "Terminé" }

  geocoded_by :place_address
  after_validation :geocode, if: :will_save_change_to_place_address?
end
