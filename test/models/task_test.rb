require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @task = @user.tasks.build(user_id: @user.id, title: 'The Title')
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "user id should be present" do
    @task.user_id = nil
    assert_not @task.valid?
  end

  test "title should be present" do
    @task.title = "   "
    assert_not @task.valid?
  end

  test "title should be at most 140 characters" do
    @task.title = "a" * 141
    assert_not @task.valid?
  end

  test "associated tasks should be destroyed" do
    @user.save
    @user.tasks.create!(title: "Lorem ipsum")
    assert_difference 'Task.count', -1 do
      @user.destroy
    end
  end
end
