FactoryBot.define do
  factory :subscription do
    association(:community, :with_submissions)
    user
  end
 end