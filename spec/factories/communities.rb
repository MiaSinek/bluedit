FactoryBot.define do
  factory :community do
    name { "Test community name" }
    title { "Test community title" }
    user { User.first || association(:user) }
  end
 end