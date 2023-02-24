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
      visited_id: post.user.id,
      action:"reply"
    )
    notification.save!
  end
end
