class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :update, :edit, :index]
  before_action :correct_user_single_task,   only: [:destroy, :edit]

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def edit
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
          @task.tags.delete_all
          # avoid pushing if it was not saved or already in db.
          # occurs when tag.name is empty
          @task.tags << tag if tag.valid?
        end
        flash["success"] = "Task updated"
        redirect_to tasks_path
      end
    rescue Exception => exception
      puts exception
      render :edit
    end
  end

  def create
    task_params_hash, tags_params_hash = split_task_tags_params
    @task = current_user.tasks.new(task_params_hash)
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
        flash[:success] = "Task created"
        redirect_to tasks_path
      end
    rescue Exception => exception
      render :new
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Task deleted"
    redirect_to tasks_path
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

  def correct_user_single_task
    @task = current_user.tasks.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      flash[:danger] = 'Not permitted because of incorrect user.'
    end
  end
end
