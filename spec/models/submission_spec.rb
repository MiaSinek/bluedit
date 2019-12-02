require 'rails_helper'

describe Submission do

  describe '#title' do
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:community) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'validate_correct_content' do
    it 'should be invalid if no content is added' do
      submission = build(:submission, body: '')

      submission.valid?

      expect(submission.errors[:base]).to include("Please add some content!")
    end

    it 'should not allow both video and image upload at the same time' do
      community = build_stubbed(:community)
      submission = build_stubbed(:submission, :with_image, :with_video, community: community, title: nil)

      submission.valid?

      expect(submission.errors[:base]).to include("Too much info! You can add video OR image, but not both!")
    end
  end
end