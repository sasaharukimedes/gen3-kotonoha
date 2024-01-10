class Reply < ApplicationRecord
  belongs_to :post
  has_many :notifications, dependent: :destroy

  validates :dear, presence: true,
                    length: {maximum:25}
  validates :content, presence: true,
                      length: {maximum:200}
  validates :from, presence: true,
                    length:{maximum:25}
  validates :post_id, presence: true
  validates :sender_archives, inclusion: {in: [true, false]}
  validates :receiver_archives, inclusion: {in: [true, false]}


  #いったんこっちでやる
  def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      reply_id:self.id,
      visited_id: post.sender.id,
      action:"reply"
    )
    notification.save!
  end

  def archive_by(user)
    if post.sender_id == user.id
      update(receiver_archives: true)
    else
      update(sender_archives: true)
    end
  end

  def self.create_with_notification(reply_params, post, current_user)
    reply = new(reply_params)
    reply.post_id = post.id
    receiver = post.sender

    ActiveRecord::Base.transaction do
      reply.save!
      reply.create_notification_by(current_user)
      NotificationMailer.notification_email(receiver).deliver
    end

    reply
  rescue ActiveRecord::RecordInvalid
    nil
  end

end
