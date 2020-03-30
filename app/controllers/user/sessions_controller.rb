# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  include InertiaCsrf

  before_action :ensure_no_user, only: [:new]

  def new
    render inertia: "Auth/Login", props: {}
  end

  def create
    user = User.find_for_database_authentication(email: params.dig(:user, :email))

    if user && user.valid_password?(params.dig(:user, :password)) && user.access_locked?
      set_flash_message!(:alert, "locked", scope: "devise.failure")
      redirect_to new_user_session_path
      return
    end

    if (self.resource = warden.authenticate(auth_options))
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      redirect_to after_sign_in_path_for(resource)
    else
      flash.alert = "Invalid email or password!"
      redirect_to root_url(subdomain: "app")
    end
  end

  def destroy
    super
  end

  private

  def current_account
    @current_account ||= Account.find_by(subdomain: request.subdomain)
  end

  def ensure_no_user
    return if current_user.nil?
    flash.alert = "You must be signed out to access that page"
    redirect_back(fallback_url: root_path)
  end

  def after_sign_in_path_for(resource)
    if resource.accounts.count.zero?
      new_account_url(subdomain: "app")
    elsif resource.accounts.count == 1
      root_url(subdomain: resource.accounts.first.subdomain)
    else
      launch_pad_url(subdomain: "app")
    end
  end

  def after_sign_out_path_for(resource_name)
    root_url(subdomain: "app")
  end
end
