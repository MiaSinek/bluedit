FactoryBot.define do
  # community factory without associated submissions
  factory :community do
    sequence(:name) { |n| "Test community#{n} name" }
    sequence(:title) { |n| "Test community#{n} title" }
    sequence(:user) { association(:user) }

    #  create submission data after the community has been created
    trait :with_submissions do
      # submission_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        submissions_count { 5 }
      end

      # the after(:create) yields two values; the community instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |community, evaluator|
        evaluator.submissions_count.times do
          create(:submission, :with_body, community: community)
        end
      end
    end
  end
 end