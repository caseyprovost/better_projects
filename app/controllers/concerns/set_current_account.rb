module SetCurrentAccount
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.account = current_account
    end
  end
end
