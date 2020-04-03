class LaunchPadController < ApplicationController
  before_action :authenticate_user!

  def show
    render inertia: "LaunchPad", props: {
      accounts: current_user.accounts
    }
  end

  def choose
    account = current_user.accounts.find(params[:account_id])
    response.set_header("X-Inertia-Location", root_url(subdomain: account.subdomain))
    head 409
  end
end
