require 'rails_helper'

RSpec.feature "User updates a task", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "Things To Do", user_id: user.id)}
  let!(:task) { Task.create(title: "Task1",
                            description: "Do This",
                            due_date: Date.new,
                            list_id: list.id) }

  before do
    login
  end

  scenario "successfully" do
    visit user_list_task_path(user.url, list, task)
    click_on "Edit"

    expect(current_path).to eq(edit_user_list_task_path(user.url, list, task))

    fill_in "Title", with: "Task NOT 1"
    fill_in "Description", with: "Things to don't"
    fill_in "Due date", with: Date.new
    click_on "Submit"

    expect(current_path).to eq(user_list_task_path(user.url, list, task))
    expect(page).to have_content("Things to don't")
  end

  scenario "unsuccessfully" do
    visit user_list_task_path(user.url, list, task)
    click_on "Edit"

    expect(current_path).to eq(edit_user_list_task_path(user.url, list, task))

    fill_in "Title", with: ""
    fill_in "Description", with: ""
    fill_in "Due date", with: ""
    click_on "Submit"

    expect(page).to have_content("Edit #{task.title}")
  end
end
