require 'rails_helper'

describe Submission do

  describe '#body' do
    it { should validate_length_of(:body) }
  end

  describe '#title' do
    it { should validate_presence_of(:title) }
  end

  describe '#url' do
    it 'validation should fail if url is invalid' do
      submission = build_stubbed(:submission, url: 'foo')

      submission.valid?

      expect(submission.errors[:url]).to include("is not a valid URL")
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:community) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'validate_correct_content' do
    context 'should be invalid if' do
      it 'no content is added' do
        submission = build(:submission, body: '')

        submission.valid?

        expect(submission.errors[:base]).to include("Please add some content!")
      end

      it 'both video and image is uploaded at the same time' do
        community = build_stubbed(:community)
        submission = build_stubbed(:submission, :with_image, :with_video, community: community, title: nil)

        submission.valid?

        expect(submission.errors[:base]).to include("Too much info! You can add video OR image, but not both!")
      end
    end

    context 'should be valid if' do
      before(:each) do
        @community = build_stubbed(:community)
      end

      it 'it is a Link Submission (only title and url is specified)' do
        submission = build_stubbed(:submission, :with_url, community: @community)

        expect(submission).to be_valid
      end

      it 'it is an Image Submission (only title and image is specified)' do
        submission = build_stubbed(:submission, :with_image, community: @community)

        expect(submission).to be_valid
      end

      it 'it is a Video Submission (only title and video is specified)' do
        submission = build_stubbed(:submission, :with_video, community: @community)

        expect(submission).to be_valid
      end

      it 'it is a Text Submission (only title and body is specified)' do
        submission = build_stubbed(:submission, :with_body, community: @community)

        expect(submission).to be_valid
      end
    end
  end
end