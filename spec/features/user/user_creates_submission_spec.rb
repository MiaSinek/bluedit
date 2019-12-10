require "rails_helper"

feature "user creates submission" do
  before(:each) do
    @community = create(:community)
    login_as create(:user)

    visit root_path
    click_on "New Submission"
  end

  scenario "of type 'post' successfully", js:true do
    fill_in 'submission[title]', with: 'Test Submission'

    # Only works with JS turned on!
    find('trix-editor').click.set('Test Submission Body!')

    select @community.name, from: 'submission[community_id]'

    click_on "Create Submission"

    expect(page).to have_css('h1', text:"w/#{@community.name}")
    expect(page).to have_css('h1', text: 'Test Submission')
    expect(page).to have_css('div.trix-content', text: 'Test Submission Body!')
  end

  scenario "of type 'link' successfully" do
    find(:xpath, '//a[contains(., "Link")]').click

    fill_in 'submission[title]', with: 'Test Link Submission'
    fill_in 'submission[url]', with: 'https://www.google.com'

    select @community.name, from: 'submission[community_id]'

    click_on "Create Submission"

    expect(page).to have_css('h1', text:"w/#{@community.name}")
    expect(page).to have_css('h1', text: 'Test Link Submission')
    expect(page).to have_link('https://www.google.com', href:'https://www.google.com')
  end

  scenario "of type 'image' successfully" do
    find(:xpath, '//a[contains(., "Image")]').click

    fill_in 'submission[title]', with: 'Test Image Submission'
    attach_file("Upload Image", Rails.root + "spec/fixtures/files/image1.jpeg")

    select @community.name, from: 'submission[community_id]'

    click_on "Create Submission"

    expect(page).to have_css('h1', text:"w/#{@community.name}")
    expect(page).to have_css('h1', text: 'Test Image Submission')
    expect(page).to have_css("img[src*='image1.jpeg']")
  end

  scenario "of type 'video' successfully" do
    find(:xpath, '//a[contains(., "Video")]').click

    fill_in 'submission[title]', with: 'Test Video Submission'
    attach_file("Upload Video", Rails.root + "spec/fixtures/files/video1.mp4")

    select @community.name, from: 'submission[community_id]'

    click_on "Create Submission"

    expect(page).to have_css('h1', text:"w/#{@community.name}")
    expect(page).to have_css('h1', text: 'Test Video Submission')
    expect(page).to have_css("video[src*='video1.mp4']")
  end

  scenario "unsuccessfully" do
    click_on "Create Submission"

    expect(page).to have_text('errors prohibited this submission from being saved')
  end
end
