FactoryBot.define do
  factory :account_member do
    association :account
    association :user
    association :role, factory: :account_role
  end
end
