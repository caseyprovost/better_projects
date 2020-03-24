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

  def current_account
    return nil if current_user.nil?

    if session[:account_id]
      @current_account ||= current_user.accounts.find(session[:account_id])
    else
      @current_account ||= current_user.accounts.first
    end
  end

  def set_current_account(account)
    session[:account_id] = account.id
  end

  def current_account_member
    return nil if current_user.nil? || current_account.nil?
    @current_account_member ||= current_account.account_memberships.includes(:role).find_by(user_id: current_user.id)
  end

  inertia_share auth: -> {
    {
      user: current_user.as_json(include: :accounts),
      account: current_account,
      account_member: current_account_member
    }
  }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number])
  end
end
