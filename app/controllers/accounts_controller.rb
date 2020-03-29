class AccountsController < ApplicationController
  before_action :enforce_no_account, only: [:new]

  def new
    render inertia: "Account/NewAccount", props: {}
  end

  def create
  end

  def edit
    render inertia: "Account/EditAccount", props: {}
  end

  def update
  end

  def destrpy
  end

  private

  def account_params
  end

  def enforce_no_account
    return if current_user.accounts.count.zero?
    flash.alert = "You already have an account"
    redirect_to edit_account_path(current_user.accounts.first)
  end
end
