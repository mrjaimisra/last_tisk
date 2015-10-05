require 'rails_helper'

RSpec.describe Users::TasksController, type: :controller do
  describe "GET index" do
    before { allow(controller).to receive(:current_user) { user } }
    before { allow(controller).to receive(:current_list) { list } }
    before { allow(controller).to receive(:current_task) { task } }

    let!(:user) { User.create(username: "Jai", password: "123") }
    let!(:list) { List.create(title: "Jai", user_id: user.id) }
    let!(:task) { Task.create(title: "T",
                              description: "Yeah!",
                              due_date: Date.new,
                              list_id: list.id,
                              user_id: user.id) }

    it "assigns tasks" do
      get :show, user: user.url, list_id: list.id, id: task.id
      expect(assigns(:task)).to eq(task)
    end

    it "renders the show template" do
      get :show, user: user.url, list_id: list.id, id: task.id
      expect(response).to render_template("show")
    end

    it "assigns @task" do
      get :new, user: user.url, list_id: list
      expect(assigns(:task)).to be_a_new(Task)
    end

    it "renders the new template" do
      get :new, user: user.url, list_id: list, task: Task.new
      expect(response).to render_template("new")
    end

    it "assigns @task" do
      get :edit, user: user.url, list_id: list, id: task.id
      expect(assigns(:task)).to eq(task)
    end

    it "renders the edit template" do
      get :edit, user: user.url, list_id: list, id: task.id
      expect(response).to render_template("edit")
    end
  end
end
