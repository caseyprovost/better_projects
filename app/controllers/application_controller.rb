class ApplicationController < ActionController::Base
  include Pundit
  include Auth
  include Pagy::Backend
  include InertiaCsrf
  include InertiaErrors
  include InertiaFlash
  include InertiaJson

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit
  before_action :set_current_attributes

  def current_account
    return nil if current_user.nil? || Account::RESERVED_SUBDOMAINS.include?(request.subdomain)
    @current_account ||= current_user.accounts.find_by(subdomain: request.subdomain)
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

  def set_current_attributes
    Current.user = current_user
    Current.account = current_account
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number])
  end
end
