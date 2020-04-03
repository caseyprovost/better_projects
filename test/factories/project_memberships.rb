FactoryBot.define do
  factory :project_membership do
    association :project
    association :user
    status { "active" }
  end
end
