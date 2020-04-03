FactoryBot.define do
  factory :bucket do
    association :account

    trait :project_bucket do
      association :bucketable, factory: :project
    end
  end
end
