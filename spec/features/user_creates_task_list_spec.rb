require 'rails_helper'

RSpec.feature "User creates a task list", type: :feature do

  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "List1", user_id: user.id) }

  before do
    login
  end

  scenario "successfully" do
    visit user_lists_path(user.url)

    click_on "Add A New List"

    expect(current_path).to eq(new_user_list_path(user.url))

    fill_in "Title", with: "New List"
    click_on "Submit"

    new_list = List.last

    expect(current_path).to eq(user_list_path(user.url, new_list))
    expect(page).to have_content("New List")
  end

  scenario "unsuccessfully without a title" do
    visit user_lists_path(user.url)
    click_on "Add A New List"

    expect(current_path).to eq(new_user_list_path(user.url))

    fill_in "Title", with: ""
    click_on "Submit"

    expect(page).to have_content("Title can't be blank")
  end
end
