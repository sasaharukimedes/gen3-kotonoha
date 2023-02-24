class RepliesController < ApplicationController
  before_action :check_logged_in

  def archive
    @reply = Reply.find(params[:id])
    if reply.post.sender_id = current_user.id
      @reply.update(receiver_archives: true)
    else
      @reply.update(sender_archives: true)
    end
    redirect_to notifications_path
  end

  def show
    @reply = Reply.find(params[:id])
  end

  def new
    @reply = Reply.new
    @post = Post.find(params[:post_id])
  end

  def create
    @reply = Reply.new(reply_params)
    @post = Post.find(params[:post_id])
    @reply.post_id = @post.id
    #@receiver = User.where(id:@reply.post.sender_id)
    #大久保さんに聞いたやつ
    #@receiver = User.find_by!(id:@reply.post.sender_id)
    @receiver = @reply.post.user
    if @reply.save
      #通知メソッドの呼び出し
      @reply.create_notification_by(current_user)
      flash[:notice] = "返事が作られました!"
      NotificationMailer.notification_email(@receiver).deliver
      redirect_to root_path
    else
      render "new"
    end

    rescue ActiveRecord::RecordInvalid => e
      pp e.record.errors



  end


      private
        def reply_params
          params.require(:reply).permit(:dear, :content, :from, :post_id, :sender_archives, :receiver_archives)
        end
end
