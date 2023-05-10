class SessionsController < ApplicationController
  #skip_before_action :check_logged_in, except: :destroy

  def new
  end

  def create
    if (user = User.find_or_create_from_auth_hash(auth_hash, status))
      log_in user
      #ユーザーの名前と誕生日がない場合のみeditに遷移
      if user_needs_profile?(user)
        redirect_to edit_profile_path
      else
        redirect_to root_path
        flash[:notice] = "コトノハへようこそ！"
      end

    else
      render new_session_path
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

        def user_needs_profile?(user)
          !user.name.present? || !user.birthday.present?
        end

end
