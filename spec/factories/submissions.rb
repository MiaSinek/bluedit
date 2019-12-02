FactoryBot.define do
  factory :submission do
    title { "Test submission title" }
    user
  end

  trait :with_body do
    body { "Test submission body" }
  end

  trait :with_url do
    url { 'https://www.somelink.com' }
  end

  trait :with_image do
    submission_image { fixture_file_upload 'spec/fixtures/files/image1.jpeg', 'image/jpg' }
  end

  trait :with_video do
    submission_video { fixture_file_upload 'spec/fixtures/files/video1.mp4', 'video/mp4' }
  end
end