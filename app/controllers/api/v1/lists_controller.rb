class Api::V1::ListsController < ApplicationController
  # http_basic_authenticate_with name: "admin", password: "password"
  skip_before_filter :restrict_access_2

  respond_to :json, :xml

  # before_action :authenticate!, except: [:index, :show]

  def index
    @user = User.find_by(token: params[:token])
    respond_with List.where(user_id: @user.id)
  end

  def show
    @user = User.find_by(token: params[:token])
    respond_with List.find_by(id: params[:id]) if params[:token] == @user.token
  end

  # private

  def list_params
    params.require(:list).permit(:title, :user_id, :status)
  end

  # def authenticate!
  #   authenticate_or_request_with_http_basic("Please authenticate to use API") do |username, password|
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
