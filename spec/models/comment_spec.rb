require 'rails_helper'

describe Comment do
  describe 'associations' do
    it { should belong_to(:submission) }
    it { should belong_to(:user) }
  end

  describe '#body' do
    it { should validate_presence_of(:body) }
  end
end