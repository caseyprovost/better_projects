class LaunchPadController < ApplicationController
  # before_action :authenticate_user!

  def show
    render inertia: "LaunchPad", props: {
      accounts: current_user.accounts
    }
  end

  def choose
    account = current_user.accounts.find(params[:account_id])
    redirect_to root_url(subdomain: account.subdomain)
  end
end
