class NotificationsController < ApplicationController
  before_action :check_logged_in

  def index
    @notifications = current_user.passive_notifications.includes(:post, :reply).order(created_at: :desc).limit(10)
  end

  def update
    @notification = Notification.find(params[:id])
    if notification.update(checked: true)
      redirect_to notifications_path
    end
  end

end
