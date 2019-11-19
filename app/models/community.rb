class Community < ApplicationRecord
  belongs_to :user

  has_many :submissions
  has_many :subscriptions
  has_many :users, through: :subscriptions

  validates_presence_of :title, :name
end
