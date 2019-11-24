require 'support/features/guest_redirected_to_login.rb'
require "rails_helper"

feature "guest is redirected to login page" do
  scenario "when trying to create a community" do
    guest_is_redirected_to_login_when_clicking_on "New Community"
  end

  scenario "when trying to create a submission" do
    guest_is_redirected_to_login_when_clicking_on "New Submission"
  end
end