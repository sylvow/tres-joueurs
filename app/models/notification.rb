class Notification < ApplicationRecord
  belongs_to :request

  enum status: [ :unread, :read ]

end
