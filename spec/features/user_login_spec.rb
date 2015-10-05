require 'rails_helper'

RSpec.feature "User can login", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }

  scenario "successfully" do
    visit root_path

    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Login"

    expect(current_path).to eq(user_lists_path(user.url))
  end
end
