class Game < ApplicationRecord
  has_many :meetings
  validates :name, presence: true

end
