class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

  def default_url_options
    I18n.locale.to_s == I18n.default_locale.to_s ? {} : { lang: I18n.locale }
  end

  private

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name])
  end

  def after_sign_in_path_for(user)
    flash[:alert] = "Hello, #{current_user.first_name}!"
    user.admin? ? admin_tests_path : root_path
  end

end
