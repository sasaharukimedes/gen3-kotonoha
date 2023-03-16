class SessionsController < ApplicationController
  #skip_before_action :check_logged_in, except: :destroy

  def new
  end

  def create
    if (user = User.find_or_create_from_auth_hash(auth_hash, status))
      log_in user
      redirect_to edit_profile_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

        private

        def auth_hash
          request.env['omniauth.auth']
        end

end
