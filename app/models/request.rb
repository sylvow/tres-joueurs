class Request < ApplicationRecord
  enum status: { interested: 0, accepted: 1, rejected: 2 }

  belongs_to :meeting
  belongs_to :user
end
