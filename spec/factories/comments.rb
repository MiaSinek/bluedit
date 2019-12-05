FactoryBot.define do
  factory :comment do
    sequence(:body) { |n| "I'm comment#{n}'s body!" }
  end
end