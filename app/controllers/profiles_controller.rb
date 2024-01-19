# frozen_string_literal: true

class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def show; end

  def create; end

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update(update_params.merge(status: 'registered', received_at: Time.current))
      redirect_to root_url
      flash[:notice] = '初めまして！コトノハへようこそ！'
      # のちのちposts_path
    else
      render :edit
      # redirect_to root_path
    end
  end

  private

  def update_params
    params.require(:user).permit(:name, :birthday, :received_at)
  end
end
