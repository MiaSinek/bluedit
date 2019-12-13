class Community < ApplicationRecord
  belongs_to :user

  has_many :submissions, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates_presence_of :title, :name
end
