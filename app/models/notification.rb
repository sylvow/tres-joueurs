class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true

  enum status: %i[unread read]
end
