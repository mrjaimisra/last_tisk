require 'rails_helper'

RSpec.feature "User can sign up for new account", type: :feature do

  scenario "successfully" do
    visit root_path

    click_link "Sign up"

    fill_in "Username", with: "Jorge"
    fill_in "Password", with: "123"
    click_button "Create Account"

    user = User.find_by(username: "Jorge")

    expect(current_path).to eq(user_lists_path(user))
    expect(page).to have_content("Jorge")
  end
end
