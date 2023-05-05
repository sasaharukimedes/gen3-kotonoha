class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def show
  end

  def create
  end

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update(update_params.merge(status: 'registered',received_at: Time.now))
      redirect_to root_url, notice: "コトノハへようこそ！"
      #のちのちposts_path
    else
      redirect_to root_path
    end
  end

      private
      def update_params
        params.require(:user).permit(:name, :birthday, :received_at ,:password, :password_confirmation)
      end
end
