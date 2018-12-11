class AddUserTaskAssociation < ActiveRecord::Migration[5.2]
  def up
    Task.delete_all
    add_column :tasks, :user_id, :integer
  end

  def down
    change_column :tasks, :user_id, :integer
  end
end
