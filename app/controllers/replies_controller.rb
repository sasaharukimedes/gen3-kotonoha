# frozen_string_literal: true

class RepliesController < ApplicationController
  before_action :check_logged_in

  def new
    @reply = Reply.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @reply = Reply.create_with_notification(reply_params, @post, current_user)
    if @reply.errors.any?
      render 'new'
    else
      flash[:notice] = '返事が作られました!'
      redirect_to root_path
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = e.record.errors.full_messages.first
    redirect_to new_post_reply_path(@post)
  end

  def show
    @reply = Reply.joins(:post).where(id: params[:id], posts: { sender_id: current_user.id }).first
    return if @reply

    flash[:error] = '表示しようとしているメッセージはあなたのものではありません。'
    redirect_to root_path
  end

  def archive
    @reply = Reply.find(params[:id])
    @reply.archive_by(current_user)
    redirect_to notifications_path
  rescue StandardError => e
    flash[:error] = "エラーが発生しました: #{e.message}"
    redirect_to root_path
  end

  private

  def reply_params
    params.require(:reply).permit(:dear, :content, :from, :post_id, :sender_archives, :receiver_archives)
  end
end
