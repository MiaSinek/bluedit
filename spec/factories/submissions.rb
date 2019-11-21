FactoryBot.define do
  factory :submission do
    submission_image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/image1.jpeg'))) }
  end
 end