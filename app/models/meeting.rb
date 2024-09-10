class Meeting < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :requests
  has_many :messages

  accepts_nested_attributes_for :game
end
