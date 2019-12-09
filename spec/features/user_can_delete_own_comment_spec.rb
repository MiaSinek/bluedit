require "rails_helper"

feature "user deletes own comment" do
  scenario "successfully", js:true do
    submission = create(:submission, :with_body, :with_comments)
    comment = submission.comments.sample
    user = comment.user

    login_as user

    visit submission_path(submission)

    accept_confirm do
      find(:css, "div#comment-#{comment.id} a[role='delete-comment']").click
    end

    expect(page).not_to have_css "div#comment-#{comment.id}"
    expect(page).to have_selector("#comment-#{comment.id}-destroy-notice", text: "Comment was successfully destroyed.")
  end
end
