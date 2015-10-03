class ArchiveController < ApplicationController
  def index
    @lists = List.where(status: 1)
  end
end
