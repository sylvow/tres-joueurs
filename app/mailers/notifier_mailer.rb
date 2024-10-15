class NotifierMailer < ApplicationMailer
  def notification_email
    @notification = params[:notification]
    @user = params[:user]
    # @url = params[:url]
    mail(to: @user.email, subject: 'Vous avez une nouvelle notification')
  end

  def mail_test(recipient)
    mail(
      to: recipient,
      subject: 'Test de mail'
    )
  end
end
