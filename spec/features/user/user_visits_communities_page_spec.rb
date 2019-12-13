require 'support/features/sign_in.rb'
require "rails_helper"

feature "User visits communities page" do
  scenario "successfully" do
    2.times { create(:community) }

    visit communities_path

    expect(page.text).to match(/Test community\d+ title/)
    expect(page.text).to match(/Test community\d+ name/)
  end
end