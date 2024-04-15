class SessionsController < ApplicationController

  skip_before_action :authenticate_user!

  def new

  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies.delete(:request_path) || root_path
    else
      flash.now[:alert] = 'Wrong email or password. Please try again'
      render :new
    end
  end

  # 3
  def destroy
    reset_session
    redirect_to root_path, notice: 'You have logged out of the site'
  end
end
