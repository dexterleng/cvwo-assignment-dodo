class AddUserTaskAssociation < ActiveRecord::Migration[5.2]
  def up
    Task.all.each do |task|
      task.tags.destroy_all
    end
    add_column :tasks, :user_id, :integer
  end

  def down
    change_column :tasks, :user_id, :integer
  end
end
