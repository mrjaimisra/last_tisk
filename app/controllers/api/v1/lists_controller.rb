class Api::V1::ListsController < ApplicationController
  before_filter :restrict_access

  respond_to :json, :xml

  def index
    user = User.find_by(token: params[:access_token])
    respond_with user.lists
  end

  def show
    @user = User.find_by(token: params[:access_token])
    respond_with List.find_by(id: params[:id])
  end

  private

    def list_params
      params.require(:list).permit(:title, :user_id, :status)
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
