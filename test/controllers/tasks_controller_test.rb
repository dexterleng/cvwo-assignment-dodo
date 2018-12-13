class TasksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @task = tasks(:yeet)
    @user.tasks << @task
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Task.count' do
      post tasks_path, params: { task: { title: "Lorem ipsum"}}
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Task.count' do
      delete task_path(@task)
    end
    assert_redirected_to login_path
  end

  test "should redirect index when not logged in" do
    get tasks_path
    assert_redirected_to login_path
  end

  test "should redirect edit when not logged in" do
    get edit_task_path(@task)
    assert_redirected_to login_path
  end

  test "should redirect update when not logged in" do
    put task_path(@task)
    assert_redirected_to login_path
  end
end
