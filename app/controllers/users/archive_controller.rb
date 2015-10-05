class Users::ArchiveController < Users::UsersController
  def index
    @lists = current_user.lists.where(status: 1)
  end
end
