class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @task.tags.build()
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    task_params_hash, tags_params_hash = split_task_tags_params

    begin
      ActiveRecord::Base.transaction do
        @task.update_attributes!(task_params_hash)
        tags_params_hash.values.each do |tag_hash|
          tag = Tag.new(tag_hash)
          tag = tag.save_if_not_exists
          @task.tags.delete_all!
          # avoid pushing if it was not saved or already in db.
          # occurs when tag.name is empty
          @task.tags << tag if tag.valid?
        end
        redirect_to tasks_path
      end
    rescue Exception => exception
      render :edit
    end
  end

  def create
    task_params_hash, tags_params_hash = split_task_tags_params
    @task = Task.new(task_params_hash)
    begin
      ActiveRecord::Base.transaction do
        @task.save!
        tags_params_hash.values.each do |tag_hash|
          tag = Tag.new(tag_hash)
          tag = tag.save_if_not_exists
          # avoid pushing if it was not saved or already in db.
          # occurs when tag.name is empty
          @task.tags << tag if tag.valid?
        end
        redirect_to tasks_path
      end
    rescue Exception => exception
      render :new
    end
  end

  def add_tag
    @task.tags.build()
  end

  private

  def task_params
    params.require(:task).permit(:title, tags_attributes: [:name])
  end

  def split_task_tags_params
    task_params_hash = task_params
    tags_params_hash = task_params[:tags_attributes] || {}
    task_params_hash.delete(:tags_attributes)
    [task_params_hash, tags_params_hash]
  end
end
