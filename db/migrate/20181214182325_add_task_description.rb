class AddTaskDescription < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :desc, :text
  end

  def down
    remove_column :tasks, :desc
  end
end
