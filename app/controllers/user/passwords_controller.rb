# frozen_string_literal: true

class User::PasswordsController < Devise::PasswordsController
  before_action :ensure_user_confirmed, only: [:create]
  before_action :ensure_user_not_locked, only: [:create]
  # GET /resource/password/new
  def new
    render inertia: "Auth/PasswordReset", props: {}
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      set_flash_message!(:notice, "send_instructions", scope: "devise.passwords")
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      flash.alert = "Sorry, we didn’t recognize that email address. Want to try another?"
      redirect_back(fallback_location: new_user_password_path)
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        resource.after_database_authentication
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def ensure_user_confirmed
    return if user.nil? || user&.confirmed?
    flash.alert = "You must confirm your account before you reset your password."
    redirect_to root_path
  end

  def ensure_user_not_locked
    return if user.nil? || !user&.access_locked?
    flash.alert = "Your account is locked. Please contact to support to reset your password."
    redirect_to root_path
  end

  def user
    @user ||= User.find_by(email: params.dig(:user, :email))
  end

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
