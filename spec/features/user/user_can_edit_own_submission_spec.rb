require "rails_helper"

feature "user edits own submission" do
  scenario "successfully" do
    community1 = create(:community)
    community2 = create(:community, :with_submissions, submissions_count: 1)
    submission = community2.submissions.last

    login_as submission.user

    visit submission_path(submission)

    find(:xpath, "//div[@class='submission-content']//a[contains(@href,'/edit')]").click

    fill_in 'submission[title]', with: 'Edited Submission Title'
    click_on 'Update Submission'

    expect(page).to have_css "div.submission-content h1.text-xl", text: "Edited Submission Title"
    expect(page).to have_css "h1", text: community2.name
  end

  scenario "unsuccessfully" do
    submission = create(:submission, :with_body)

    login_as submission.user

    visit edit_submission_path(submission)

    fill_in 'submission[title]', with: ''
    click_on 'Update Submission'

    expect(page).to have_text "1 error prohibited this submission from being saved"
    expect(page).to have_text "Title can't be blank"
  end
end

feature "There is an 'Edit' link" do
  before(:each) do
    @community = create(:community, :with_submissions, submissions_count: 1)
    @submission = @community.submissions.last

    login_as @submission.user
  end

  scenario "on the user's own submission's show page" do
    visit submission_path(@submission)

    expect(page).to have_xpath "//div[@class='submission-content']//a[contains(@href,'/edit')]"
  end

  scenario "on the root path to the user's own submission" do
    create(:subscription, community: @community, user: @submission.user)

    visit root_path

    expect(page).to have_xpath "//a[contains(@href,'#{@submission.id}/edit')]"
  end

  scenario "on the community's index page to the user's own submission" do
    visit community_path(@community)

    expect(page).to have_xpath "//a[contains(@href,'#{@submission.id}/edit')]"
  end
end