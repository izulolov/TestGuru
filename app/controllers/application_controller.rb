class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :email, :password, :password_confirmation])
  end

  def after_sign_in_path_for(current_user)
    current_user.is_a?(Admin) ? admin_tests_path : root_path
  end

end
