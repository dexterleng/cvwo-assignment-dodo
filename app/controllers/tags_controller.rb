class TagsController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    @tasks = current_user.tasks.includes(:tags)
    @tags_tasks = group_tasks_by_tag(@tasks)
  end

  private

  # tag.name -> tasks
  def group_tasks_by_tag(tasks)
    tags_tasks = {}
    tasks.each do |task|
      task.tags.each do |tag|
        tags_tasks[tag.name] = [] unless tags_tasks.key?(tag.name)
        tags_tasks[tag.name] << task
      end
    end
    return tags_tasks
  end
end
