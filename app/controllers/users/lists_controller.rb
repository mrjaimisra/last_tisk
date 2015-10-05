class Users::ListsController < Users::UsersController
  before_action :current_list, :authorize!, except: [:index, :new, :create]

  def index
    @user = User.find_by(params[:url])
    @lists = @user.lists.where(status: "unarchived")
  end

  def show
    @list = current_list
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to user_list_path(current_user.url, @list)
    else
      render :new
    end
  end

  def edit
    @list = List.find_by(id: params[:id])
  end

  def update
    @list = current_list
    if current_list.update_attributes(list_params)
      redirect_to user_list_path(current_user.url, current_list)
    else
      flash.now[:danger] = "Update failed, please enter valid information"
      render :edit
    end
  end

  def destroy
    current_list.destroy

    redirect_to user_lists_path
    flash[:message] = "List successfully deleted"
  end

  def archived
    current_list.update_attribute(:status, "archived")
    current_list.save

    redirect_to user_list_path(current_user.url, current_list)
  end

  def unarchived
    current_list.update_attribute(:status, "unarchived")
    current_list.save

    redirect_to user_list_path(current_user.url, current_list)
  end

  private

  def list_params
    params.require(:list).permit(:title, :user_id, :status)
  end

  def authorized?
    current_list.user_id == current_user.id
  end

  def current_list
    @current_list = List.find_by(id: params[:id])
  end
end
