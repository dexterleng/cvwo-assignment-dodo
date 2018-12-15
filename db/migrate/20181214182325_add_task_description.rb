class AddTaskDescription < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :desc, :text
  end
end
