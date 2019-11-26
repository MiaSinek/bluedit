FactoryBot.define do
  factory :subscription do
    association :community
    user { User.first || association(:user) }
  end
 end