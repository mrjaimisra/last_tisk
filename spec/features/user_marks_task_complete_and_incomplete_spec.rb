require 'rails_helper'

RSpec.feature "User changes the status of a task list", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "Things To Do", user_id: user.id) }
  let!(:task) { Task.create(title: "Task1",
                            description: "Do This",
                            due_date: Date.new,
                            list_id: list.id) }

  before do
    login
  end

  scenario "successfully" do
    visit user_list_path(user.url, list)

    expect(page).to have_content(list.title)

    expect(page).to have_link(task.title)
    click_link(task.title)

    expect(page).to have_content("incomplete")

    click_on("Mark complete")

    expect(current_path).to eq(user_list_task_path(user.url, list, task))
    expect(page).to have_content("complete")

    click_on "Mark incomplete"

    expect(current_path).to eq(user_list_task_path(user.url, list, task))
    expect(page).to have_content("incomplete")

    click_on("Mark complete")

    click_on list.title

    expect(current_path).to eq(user_list_path(user.url, list))
    expect(page).to_not have_content(task.title)

    click_link "Completed Tasks"

    expect(current_path).to eq(user_list_completed_tasks_path(user.url, list))

    expect(page).to have_content(task.title)
    click_on task.title
    click_on "Mark incomplete"

    expect(current_path).to eq(user_list_task_path(user.url, list, task))

    click_link(list.title)
    expect(page).to have_content(task.title)
  end
end
