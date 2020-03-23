# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  include InertiaCsrf

  def new
    render inertia: "Auth/Login", props: {}
  end

  def create
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
end
