class Users::CompletedController < Users::UsersController
  def index
    @tasks = current_list.tasks.where(status: 1)
  end

  private

    def current_list
      @current_list = List.find_by(user_id: current_user.id)
    end
end
