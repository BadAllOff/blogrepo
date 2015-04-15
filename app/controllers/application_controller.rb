require "application_responder"

class ApplicationController < ActionController::Base
  before_filter :set_locale
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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

end
