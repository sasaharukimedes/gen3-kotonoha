# frozen_string_literal: true

class Post < ApplicationRecord
  has_one :reply, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  validates :dear, presence: true,
                   length: { maximum: 25 }
  validates :content, presence: true,
                      length: { maximum: 200 }
  validates :from, presence: true,
                   length: { maximum: 25 }
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :sender_archives, inclusion: { in: [true, false] }
  validates :receiver_archives, inclusion: { in: [true, false] }

  # いったんこっちでやる
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: receiver_id,
      action: 'post'
    )
    notification.save!
  end

  def archive_by(user)
    if receiver_id == user.id
      update!(receiver_archives: true)
    else
      update!(sender_archives: true)
    end
  end

  def self.create_with_notification(post_params, current_user)
    post = new(post_params)
    post.sender_id = current_user.id
    receiver = User.where.not(id: current_user.id).order(:received_at).first
    post.receiver_id = receiver.id

    ActiveRecord::Base.transaction do
      post.save!
      receiver.received_at = Time.current
      post.create_notification_by(current_user)
      NotificationMailer.notification_email(receiver).deliver
      receiver.save!
    end

    post
  rescue ActiveRecord::RecordInvalid => e
    post.errors.add(:base, e.message)
    post
  end
end
