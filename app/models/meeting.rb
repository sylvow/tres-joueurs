class Meeting < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :requests, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  accepts_nested_attributes_for :game

  enum status: [ :available, :full, :ongoing, :cancelled, :finished ]

  def localized_status
    I18n.t("activerecord.attributes.meeting.statuses.#{status}")
  end

  geocoded_by :place_address
  # after_validation :geocode, if: :will_save_change_to_place_address?
  # before_save :set_coordinates

  validates :title, :game_id, :players_needed_min, :location_type, :date, presence: true

  private
  # def set_coordinates
  #   result = Geocoder.search(place_address)
  #   unless result.blank?
  #     latitude = result.first.coordinates[0]
  #     longitude = result.first.coordinates[1]
  #   end
  # end
end
