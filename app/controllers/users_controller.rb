class UsersController < ApplicationController
  
  skip_before_action :authenticate_user!
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # 1
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = 'Error. Incorrect data'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
