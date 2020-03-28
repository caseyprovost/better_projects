FactoryBot.define do
  factory :project_membership do
    association :project
    association :user
    permission { 'read' }
    status { "active" }

    trait :reader do
      permission { 'read' }
    end

    trait :writer do
      permission { 'write' }
    end

    trait :admin do
      permission { 'admin' }
    end
  end
end
