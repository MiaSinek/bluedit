require 'rails_helper'

describe User do

  describe '#username' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }

  end

  describe 'associations' do
    it { should have_many(:submissions)}
    it { should have_many(:subscriptions)}
    it { should have_many(:comments)}

    it { should have_many(:communities_authored).class_name('Community')}
    it { should have_many(:communities_subscribed_to).through(:subscriptions).source(:community)}
    it { should have_many(:submissions_subscribed_to).through(:communities_subscribed_to).source(:submissions)}
  end

  describe '.add_unsubscribe_hash' do
    it 'should set the unsubscribe_hash field when creating a user' do
      user = create(:user)
      expect(user.unsubscribe_hash.size).to eq(32)
    end
  end
end