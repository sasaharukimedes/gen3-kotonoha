class PostsController < ApplicationController
  before_action :check_logged_in

  def archive
    @post = Post.find(params[:id])
    if @post.receiver_id = current_user.id
      @post.update(receiver_archives: true)
    else
      @post.update(sender_archives: true)
    end
    redirect_to notifications_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.sender_id = current_user.id
    @receiver = User.where.not(id:current_user.id).order(:received_at).first
    @post.receiver_id = @receiver.id
    if @post.save
      @receiver.received_at = Time.current
      @post.create_notification_by(current_user)
      @receiver.save
      flash[:notice] = "手紙が作られました!"
      NotificationMailer.notification_email(@receiver).deliver
      redirect_to root_path
    else
      render "new"
    end

    rescue ActiveRecord::RecordInvalid => e
      pp e.record.errors

  end


    private
        def post_params
          params.require(:post).permit(:dear, :content, :from, :sender_id, :receiver_id, :sender_archives, :receiver_archives)
        end
end
