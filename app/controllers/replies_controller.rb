class RepliesController < ApplicationController
  before_action :check_logged_in

  def archive
    begin
      @reply = Reply.find(params[:id])
      @reply.archive_by(current_user)
      redirect_to notifications_path
    rescue => e
      flash[:error] = "エラーが発生しました: #{e.message}"
      redirect_to root_path
    end
  end

  def show
    @reply = Reply.find(params[:id])
  end

  def new
    @reply = Reply.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @reply = Reply.create_with_notification(reply_params, @post, current_user)
    if @reply.errors.any?
      render "new"
    else
      flash[:notice] = "返事が作られました!"
      redirect_to root_path
    end
  rescue ActiveRecord::RecordInvalid => e
    pp e.record.errors
  end

      private
        def reply_params
          params.require(:reply).permit(:dear, :content, :from, :post_id, :sender_archives, :receiver_archives)
        end
end
