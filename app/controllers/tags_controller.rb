class TagsController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    @tags = Tag.all
  end
end
