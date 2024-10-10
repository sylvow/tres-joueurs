class NotifierMailer < ApplicationMailer
  def notification_email
    @user = params[:user]
    @notification = params[:notification]
    mail(
      to: @user.email,
      subject: 'Vous avez une nouvelle notification',
    )
  end

  def mail_test(recipient)
    mail(
      to: recipient,
      subject: 'Test de mail',
    )
  end
end
