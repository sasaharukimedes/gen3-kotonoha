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
    if @profile.update(update_params.merge(status: 'registered'))
      redirect_to profile_path
      #のちのちposts_path
    else
      render :edit
    end
  end

      private
      def update_params
        params.require(:user).permit(:name, :birthday, :password, :password_confirmation)
      end
end
