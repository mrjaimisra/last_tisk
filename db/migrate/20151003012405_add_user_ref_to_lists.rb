class AddUserRefToLists < ActiveRecord::Migration
  def change
    add_reference :lists, :users, index: true, foreign_key: true
  end
end
