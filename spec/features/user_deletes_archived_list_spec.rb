require 'rails_helper'

RSpec.feature "User deletes an archived list", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "Things To Do", user_id: user.id) }

  before do
    login
  end

  scenario "successfully" do
    visit user_list_path(user.url, list)

    expect(page).to have_content("unarchived")
    expect(page).to_not have_content("Delete")
    click_on "Archive"

    expect(current_path).to eq(user_list_path(user.url, list))
    expect(page).to have_content("archived")

    click_on "Delete"

    expect(current_path).to eq(user_lists_path(user.url))

    click_link "Archived Lists"

    expect(page).to_not have_content(list.title)
  end
end