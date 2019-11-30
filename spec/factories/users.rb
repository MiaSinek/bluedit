FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email)    { |n| "someone#{n}@example.com" }
    password { "password" }
  end
end