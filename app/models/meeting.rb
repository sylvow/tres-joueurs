class Meeting < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :requests
  has_many :messages
end
