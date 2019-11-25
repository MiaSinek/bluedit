FactoryBot.define do
  factory :community do
    name { "Test community name" }
    title { "Test community title" }
    association :user
  end
 end