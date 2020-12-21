class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_parmitted_parameters, if: :devise_controller?
  before_action :set_note

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |_username, _password|
      username = ENV['BASIC_AUTH_USER'] && password = ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def configure_parmitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def set_note
    @note = Note.new
  end
end
