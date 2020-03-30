class AccountsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def new
    render inertia: "Accounts/NewAccount", props: {}
  end

  def create
    account = Account.new(account_params.merge(owner: current_user))

    if account.save
      flash.notice = "Your account was successfully created"
      redirect_to root_url(subdomain: account.subdomain)
    else
      redirect_to new_account_path, errors: account.errors
    end
  end

  def edit
    render inertia: "Accounts/EditAccount", props: {}
  end

  def update
  end

  def destrpy
  end

  private

  def account_params
    params.require(:account).permit(:name, :subdomain)
  end
end
