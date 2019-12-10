require "rails_helper"

feature "guest goes to homepage" do
  scenario "sees all submissions" do
    community_with_submissions_1 = create(:community, :with_submissions)
    community_with_submissions_2 = create(:community, :with_submissions)

    visit root_path

    expect(page).to have_css('div[id*="submission-"]', count: 10)
    expect(page).to have_css('div[id="submission-1"]')
    expect(page).to have_css('div[id="submission-6"]')
    expect(page).to have_css('div[id="submission-10"]')
  end
end