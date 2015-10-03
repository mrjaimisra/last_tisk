require 'rails_helper'

RSpec.feature "User archives a task list", type: :feature do

  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "Things To Do", user_id: user.id)}

  scenario "successfully" do
    visit lists_path

    expect(page).to have_link(list.title)

    click_on list.title

    expect(current_path).to eq(list_path(list))

    click_on "Archive"

    expect(current_path).to eq(list_path(list))
    expect(page).to have_content("archived")

    click_on "All Lists"

    expect(current_path).to eq(lists_path)
    expect(page).to_not have_content(list.title)

    click_link "Archived Lists"

    expect(current_path).to eq(archived_lists_path)
    expect(page).to have_content(list.title)
  end
end
