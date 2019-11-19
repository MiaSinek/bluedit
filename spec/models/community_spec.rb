require 'rails_helper'

describe Community do

  describe '#name' do
    it { should validate_presence_of(:name) }
  end

  describe '#title' do
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:submissions)}
    it { should have_many(:subscriptions)}
    it { should have_many(:users).through(:subscriptions)}
  end

end
