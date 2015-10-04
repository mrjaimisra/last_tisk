class ListsController < ApplicationController
  def index
    @lists = List.where(status: "unarchived")
  end

  def show
    @list = List.find_by(id: params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def archived
    @list = List.find_by(id: params[:id])
    @list.update_attribute(:status, "archived")
    @list.save

    redirect_to list_path(@list)
  end

  def unarchived
    @list = List.find_by(id: params[:id])
    @list.update_attribute(:status, "unarchived")
    @list.save

    redirect_to list_path(@list)
  end

  private

    def list_params
      params.require(:list).permit(:title, :user_id, :status)
    end
end
