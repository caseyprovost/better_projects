class AccountMember < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :role, class_name: "AccountRole"
end
