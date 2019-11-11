class Submission < ApplicationRecord
  include VotesCountable

  mount_uploader :submission_image, SubmissionImageUploader
  mount_uploader :submission_video, SubmissionVideoUploader

  belongs_to :user
  belongs_to :community
  has_many :comments, dependent: :destroy

  validate :image_or_video, if: -> { submission_image.present? || submission_video.present? }

  validates :title, presence: true
  validates :body, length: { maximum: 8000 }
  validates :url, url: { allow_blank: true }

  acts_as_votable

  private

  def image_or_video
    if submission_image.present? && submission_video.present?
      errors.add(:base, "Add an image or a video, not both")
    end
  end
end
