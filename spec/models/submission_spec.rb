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
      submission = build_stubbed(:submission, title: '')

      submission.valid?

      expect(submission.errors[:base]).to include("Please add some content!")
    end
  end
end