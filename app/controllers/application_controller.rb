class ApplicationController < ActionController::Base
  include Pundit
  include Auth
  include Pagy::Backend
  include InertiaCsrf
  include InertiaErrors
  include InertiaFlash
  include InertiaJson

  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number])
  end
end
