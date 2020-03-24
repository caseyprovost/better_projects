# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  include InertiaCsrf

  before_action :ensure_no_user, only: [:new]

  def new
    render inertia: "Auth/Login", props: {}
  end

  def create
    user = User.find_for_database_authentication(email: params.dig(:user, :email))

    if (self.resource = warden.authenticate(auth_options))
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      flash.alert = "Invalid email or password!"
      redirect_to new_user_session_path
    end
  end

  def destroy
    super
  end

  private

  def ensure_no_user
    return if current_user.nil?
    flash.alert = "You must be signed out to access that page"
    redirect_back(fallback_url: root_path)
  end

  def after_sign_in_path_for(resource)
    super(resource)
  end
end
