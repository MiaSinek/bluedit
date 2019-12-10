require "rails_helper"

feature "guest tries to delete comment" do
  scenario "but there is no delete button on the comment on the submission's show page" do
    submission = create(:submission, :with_body, :with_comments)
    comment = submission.comments.sample

    visit submission_path(submission)

    expect(page).not_to have_css "a[href='#{submission_comment_path(submission, comment)}'][data-method='delete']"
  end
end