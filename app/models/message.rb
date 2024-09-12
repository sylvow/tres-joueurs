class Message < ApplicationRecord
  belongs_to :meeting
  belongs_to :user
  after_create_commit :broadcast_message

  private

  def broadcast_message
    broadcast_append_to "meeting_#{meeting.id}_messages",
                        partial: 'messages/message',
                        locals: { message: self, user: user },
                        target: "messages"
  end
end
