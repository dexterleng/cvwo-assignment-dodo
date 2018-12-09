class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @task.tags.build()
    @task.tags.build()
  end

  def create
    task_params_hash = task_params
    tags_params_hash = task_params[:tags_attributes]
    task_params_hash.delete(:tags_attributes)

    # need to insert tags that do not already exist first

    ActiveRecord::Base.transaction do
      task = Task.create(task_params_hash)
      tags_params_hash.values.each do |tag_hash|
        tag = Tag.new(tag_hash)
        tag = tag.save_if_not_exists
        task.tags << tag
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, tags_attributes: [:name])
  end
end
