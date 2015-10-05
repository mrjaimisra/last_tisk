class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :status, default: 0
      t.string :description
      t.date :due_date
      t.string :list_id
    end
    add_index :tasks, :list_id
  end
end
