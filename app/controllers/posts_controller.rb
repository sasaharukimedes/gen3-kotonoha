# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :check_logged_in

  def archive
    @post = Post.find(params[:id])
    @post.archive_by(current_user)
    redirect_to notifications_path
  rescue StandardError => e
    flash[:error] = "エラーが発生しました: #{e.message}"
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create_with_notification(post_params, current_user)
    if @post.errors.any?
      render 'new'
    else
      flash[:notice] = '手紙が作られました!'
      redirect_to root_path
    end
  rescue ActiveRecord::RecordInvalid => e
    pp e.record.errors
  end

  private

  def post_params
    params.require(:post).permit(:dear, :content, :from, :sender_id, :receiver_id, :sender_archives,
                                 :receiver_archives)
  end
end
