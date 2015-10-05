class Api::V1::TasksController < ApplicationController
  before_filter :restrict_access

  respond_to :json, :xml

  def index
    user = User.find_by(token: params[:access_token])
    respond_with user.tasks
  end

  def show
    @user = User.find_by(token: params[:access_token])
    respond_with Task.find_by(id: params[:id])
  end

  private

    def task_params
      params.require(:task).permit(:title,
                                   :description,
                                   :due_date,
                                   :list_id,
                                   :status)
    end

    def restrict_access
      api_key = ApiKey.find_by_access_token(params[:access_token])
      head :unauthorized unless api_key
    end

    # strategy for sending token through http headers:

    # def restrict_access_2
    #   authenticate_or_request_with_http_token do |token, options|
    #     User.find_by(token: token)
    #   end
    # end
end
