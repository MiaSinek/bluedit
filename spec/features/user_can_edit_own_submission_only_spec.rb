require 'support/features/sign_in.rb'
require "rails_helper"

feature "user edits own feature" do
  scenario "successfully" do
    community1 = create(:community)
    community2 = create(:community, :with_submissions, submissions_count: 1)
    submission = community2.submissions.last

    login_as(submission.user, :scope => :user)

    visit submission_path(submission)

    find(:xpath, "//div[@class='submission-content']//a[contains(@href,'/edit')]").click

    fill_in 'submission[title]', with: 'Edited Submission Title'
    click_on 'Update Submission'

    expect(page).to have_css "div.submission-content h1.text-xl", text: "Edited Submission Title"
    expect(page).to have_css "h1", text: community2.name
  end
end