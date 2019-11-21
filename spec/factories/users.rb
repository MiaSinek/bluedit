FactoryBot.define do
  factory :user do
    username { "Someone" }
    email    { "someone@example.com" }
    password { "password" }
    #password_confirmation: "password"
  end
end