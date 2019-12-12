require "rails_helper"

feature "user creates comment" do
  scenario "successfully", js:true do
    submission = create(:submission, :with_body)
    login_as create(:user)

    visit submission_path(submission)
    fill_in 'comment[body]', with: 'Test Comment'

    click_on "Create Comment"

    expect(page).to have_css "div#comments>div", count: 1, text: 'Test Comment'
  end

  scenario "unsuccessfully", js:true do
    submission = create(:submission, :with_body)
    login_as create(:user)

    visit submission_path(submission)

    click_on "Create Comment"

    expect(page).to have_text("Comment could not be created. Please add some awesomesauce!")
    expect(page).to have_current_path(submission_path(submission))
  end
end