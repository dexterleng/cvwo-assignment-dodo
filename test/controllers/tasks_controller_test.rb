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

  test "should delete task if logged in" do
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    delete task_path(@task)
    assert_equal 0, Task.where(id: @task.id).count
  end

  test "cannot delete other user's task " do
    user_two = users(:john)
    task_user_two = tasks(:python)
    user_two.tasks << task_user_two
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    delete task_path(task_user_two)
    assert_equal 1, Task.where(id: @task.id).count
  end

  test "can create task if logged in" do
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    post tasks_path, params: { task: { title: "CS3216" } }
    assert_equal 1, Task.where(title: "CS3216").count
  end

  test "can create tasks with tags if logged in" do
    assert_equal 0, Tag.where(name: "cs").count
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    post tasks_path, params: {"task"=>{"title"=>"CS3216", "tags_attributes"=>{"0"=>{"name"=>"cs", "_destroy"=>"false"}}}}
    assert_equal 1, Tag.where(name: "cs").count
  end

  test "does not create tag if tag with that name already exists"  do
    assert_equal 1, Tag.where(name: "school").count
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    post tasks_path, params: {"task"=>{"title"=>"CS3216", "tags_attributes"=>{"0"=>{"name"=>"school", "_destroy"=>"false"}}}}
    assert_equal 1, Tag.where(name: "school").count
  end
end
