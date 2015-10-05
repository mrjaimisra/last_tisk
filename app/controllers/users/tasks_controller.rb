class Users::TasksController < Users::UsersController
  before_action :current_task,
                :current_list,
                :authorize!, except: [:index, :new, :create]

  def show
    @task = current_task
  end

  def new
    @task = Task.new
    @list = current_list
  end

  def create
    @list = current_list
    @task = Task.new(task_params)
    @task.list_id = @list.id
    @task.user_id = List.find_by(id: @task.list_id).user.id
    if @task.save
      redirect_to user_list_task_path(current_user.url, current_list, @task)
    else
      render :new
    end
  end

  def edit
    @list = current_list
    @task = current_task
  end

  def update
    @task = current_task
    @list = current_list
    if current_task.update_attributes(task_params)
      redirect_to user_list_task_path(current_user.url, current_list, current_task)
    else
      render :edit
    end
  end

  def complete
    current_task.update_attribute(:status, "complete")
    current_task.save

    redirect_to user_list_task_path(current_user.url, current_list, current_task)
  end

  def incomplete
    current_task.update_attribute(:status, "incomplete")
    current_task.save

    redirect_to user_list_task_path(current_user.url, current_list, current_task)
  end

  private

    def task_params
      params.require(:task).permit(:title,
                                   :description,
                                   :due_date,
                                   :list_id,
                                   :status)
    end

    def authorized?
      current_list.user_id == current_user.id
    end

    def current_list
      @current_list = List.find_by(id: params[:list_id])
    end

    def current_task
      @current_task = Task.find_by(id: params[:id])
    end

end
