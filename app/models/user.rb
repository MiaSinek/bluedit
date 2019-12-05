class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :add_unsubscribe_hash

  has_many :submissions
  has_many :comments
  has_many :subscriptions

  has_many :communities_authored, class_name: 'Community'
  has_many :communities_subscribed_to, through: :subscriptions, source: :community
  has_many :submissions_subscribed_to, through: :communities_subscribed_to, source: :submissions

  validates_uniqueness_of :username
  validates_presence_of :username

  acts_as_voter

  private

  def add_unsubscribe_hash
    self.unsubscribe_hash = SecureRandom.hex
  end
end
