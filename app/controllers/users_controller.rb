class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    #params[:user]実装は終わっていないことに注意!
    #マスアサインメント脆弱性
    #user.rbに書けば以下いらない？？
    #@user.received_at = Time.now
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url, notice: "Please check your email to activate your account."
    else
      render 'new'
    end
  end


  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      #更新に成功した場合に扱う
    else
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :birthday, :received_at)
    end
end
