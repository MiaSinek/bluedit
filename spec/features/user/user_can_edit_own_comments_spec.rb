require "rails_helper"

feature "user edits own comment on the submission show page" do
  scenario "successfully", js:true do
    submission = create(:submission, :with_body, :with_comments)
    comment = submission.comments.sample
    user = comment.user

    login_as user
    visit submission_path(submission)

    find(:css, "a[href='#{edit_submission_comment_path(submission, comment)}']").click
    find(:xpath, "//form[@class='edit_comment']//textarea").set("Edited Comment Body")
    click_on 'Update Comment'

    expect(page).to have_css "div#comment-#{comment.id}", text: "Edited Comment Body"
    expect(page).to have_text "Comment was successfully updated."
  end

  scenario "unsuccessfully", js:true do
    submission = create(:submission, :with_body, :with_comments)
    comment = submission.comments.sample
    user = comment.user

    login_as user
    visit submission_path(submission)

    find(:css, "a[href='#{edit_submission_comment_path(submission, comment)}']").click
    find(:xpath, "//form[@class='edit_comment']//textarea").set("")
    click_on 'Update Comment'

    expect(page).to have_text("Comment could not be updated. Please add some awesomesauce!")
    expect(page).to have_current_path(submission_path(submission))
  end
end
