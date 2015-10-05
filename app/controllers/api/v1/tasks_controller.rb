class Api::V1::TasksController < ApplicationController
  # http_basic_authenticate_with name: "admin", password: "password"
  skip_before_filter :restrict_access_2

  respond_to :json, :xml

  # before_action :authenticate!, except: [:index, :show]

  def index
    @user = User.find_by(token: params[:token])
    respond_with @user.tasks
  end

  def show
    @user = User.find_by(token: params[:token])
    respond_with Task.find_by(user_id: @user.id) if params[:token] == @user.token
  end

  # private

  def task_params
    params.require(:task).permit(:title,
                                 :description,
                                 :due_date,
                                 :list_id,
                                 :status)
  end

  # def authenticate!
  #   authenticate_or_request_with_http_basic("please authenticate to use api") do |username, password|
  #     user = User.find_by(username: username)
  #
  #     if user && user.authenticate(password)
  #       true
  #     else
  #       head :unauthorized
  #     end
  #   end
  # end

  def restrict_access
    api_key = ApiKey.find_by_access_token(params[:access_token])
    head :unauthorized unless api_key
  end

  def restrict_access_2
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(token: token)
    end
  end
end
