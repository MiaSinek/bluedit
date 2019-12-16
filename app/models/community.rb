class Community < ApplicationRecord
  belongs_to :user

  has_many :submissions, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  after_create :auto_subscribe_author

  validates_presence_of :title, :name

  private

  def auto_subscribe_author
    Subscription.create(community: self, user: user)
  end
end
