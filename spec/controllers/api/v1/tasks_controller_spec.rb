require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do

  it "returns all of a users tasks" do
    user = User.create(username: "Jai", password: "ABCD")

    get 'index', format: :json, access_token: user.token

    expect(response.status).to eq(200)
  end

  it "returns a single task" do
    user = User.create(username: "Jai", password: "ABCD")
    list = List.create(title: "List1", user_id: user.id)
    task = Task.create(title: "Task1",
                       description: "Many Tasks",
                       due_date: Date.new,
                       list_id: list.id,
                       user_id: user.id)

    get 'show', format: :json, access_token: user.token, id: task.id

    expect(response.status).to eq(200)
  end
end
