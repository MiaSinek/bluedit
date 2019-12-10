require "rails_helper"

feature "guest tries to edit comment" do
  scenario "but there is no edit button" do
    submission = create(:submission, :with_body, :with_comments)
    comment = submission.comments.sample

    visit submission_path(submission)

    expect(page).not_to have_css "a[@href='#{edit_submission_comment_path(submission, comment)}']"
  end
end