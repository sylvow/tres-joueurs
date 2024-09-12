class MessagesController < ApplicationController

  def create
    @meeting = Meeting.find(params[:meeting_id])
    @message = Message.new(message_params)
    @message.meeting = @meeting
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
            locals: { message: @message, user: current_user })
        end
        format.html { redirect_to meeting_messages_path(@meeting) }
      end    else
      render "meeting_messages", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
