class Comment < ApplicationRecord
  include VotesCountable

  belongs_to :submission
  belongs_to :user

  validates_presence_of :body

  acts_as_votable
end
