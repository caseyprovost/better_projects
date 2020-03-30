module Accounts
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :enforce_account_exists!

    private

    def enforce_account_exists!
      return if current_account.present?

      flash.alert = "Please create an acccount before continuing"
      redirect_to new_account_path
    end
  end
end
