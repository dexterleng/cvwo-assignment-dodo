class CreateJoinTableTasksTags < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tasks, :tags do |t|
      # t.index [:task_id, :tag_id]
      # t.index [:tag_id, :task_id]
      t.references :task, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
    end
  end
end
