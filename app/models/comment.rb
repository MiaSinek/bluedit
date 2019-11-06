class Comment < ApplicationRecord
  belongs_to :submission
  belongs_to :user

  validates_presence_of :body
end
