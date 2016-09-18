require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_filter :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #cancancan Handle Unauthorized Access
  rescue_from CanCan::AccessDenied do |exception|
      begin
        redirect_to :back, :notice => exception.message
      rescue ActionController::RedirectBackError
        redirect_to root_path
      end
  end

  private

  def set_locale
    if params[:locale].present?
      I18n.locale = params[:locale]
    elsif
      request.env["HTTP_ACCEPT_LANGUAGE"] == 'ru'
      I18n.locale = 'ru'
    end
    # Можно использовать для установленных пользователем языков в настройках Аккаунта
    # current_user.locale
    # request.env["HTTP_ACCEPT_LANGUAGE"]
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

end
