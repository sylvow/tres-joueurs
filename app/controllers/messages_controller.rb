class MessagesController < ApplicationController
  def index
    @my_messages = current_user.messages
  end
end
