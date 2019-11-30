FactoryBot.define do
  factory :subscription do
    association(:community)
    association(:user)
  end
 end