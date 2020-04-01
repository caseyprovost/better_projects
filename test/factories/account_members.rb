FactoryBot.define do
  factory :account_member do
    association :account
    association :user
    association :role, factory: :account_role

    trait :admin do
      role { AccountRole.find_or_create_by(name: "Admin") }
    end

    trait :reader do
      role { AccountRole.find_or_create_by(name: "Reader") }
    end

    trait :writer do
      role { AccountRole.find_or_create_by(name: "Writer") }
    end
  end
end
