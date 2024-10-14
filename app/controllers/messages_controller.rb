class MessagesController < ApplicationController

  def create
    @meeting = Meeting.find(params[:meeting_id])
    @message = Message.new(message_params)
    @message.meeting = @meeting
    @message.user = current_user
    if @message.save
      @notification = Notification.new(
        notifiable_type: 'Message',
        notifiable_id: @message.id,
        category: 'new-message',
        content: "Nouveau message reçu pour #{@message.meeting.game.name} le #{@message.meeting.date.strftime('%d/%m/%y')}")
      @notification.unread!
      @notification.save!
      # raise
      NotifierMailer.with(user: @message.meeting.user, notification: @notification).notification_email.deliver_now
      # , url: meeting_messages_path(@message.meeting)
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
