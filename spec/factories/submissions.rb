FactoryBot.define do
  factory :submission do
    title { "Test submission title" }
    body { "Test submission body" }
    user
  end
 end