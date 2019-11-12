class Submission < ApplicationRecord
  include VotesCountable

  mount_uploader :submission_image, SubmissionImageUploader
  mount_uploader :submission_video, SubmissionVideoUploader

  belongs_to :user
  belongs_to :community
  has_many :comments, dependent: :destroy

  validate :validate_correct_content

  validates :title, presence: true
  validates :body, length: { maximum: 8000 }
  validates :url, url: { allow_blank: true }

  acts_as_votable

  private

  def validate_correct_content
    content_count = [url, body, submission_image, submission_video].map(&:present?).count(true)

    if content_count == 0
      errors.add :base, "Please add some content!"
    elsif content_count == 2 # the UI is reseting the form when switching tabs, the only way to
                             # add two contents is in the video/image upload tab, hance content_count == 2
      errors.add :base, "Too much info! You can add video OR image, but not both!"
    end
  end
end


