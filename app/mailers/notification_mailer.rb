class NotificationMailer < ApplicationMailer

  def notification_email(receiver)
    @receiver = receiver
    #ここはデプロイした先のURL
    @url = "https://kotonoha3.onrender.com/notifications"
    mail(to:"#{@receiver.email}", subject: 'お手紙が届いています！')
  end

end