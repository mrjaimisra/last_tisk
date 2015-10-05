require 'rails_helper'

RSpec.feature "User can login", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }

  scenario "successfully" do
    visit root_path

    within(".header-nav") do
      click_on "Login"
    end

    expect(current_path).to eq(login_path)

    within(".login-form") do
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Login"
    end

    expect(current_path).to eq(user_lists_path(user.url))
    expect(page).to have_content(user.username)
  end

  scenario "and then logout" do
    login

    within(".header-nav") do
      click_link "Logout"
    end

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content(user.username)
    expect(page).to have_link("Login")
  end
end
