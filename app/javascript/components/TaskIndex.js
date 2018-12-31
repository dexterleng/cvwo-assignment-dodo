import React from "react"
import TaskRow from './TaskRow';
class TaskIndex extends React.Component {
  state = {
    tasks: [],
    tags: null,
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    if (nextProps.tasks !== prevState.tasks){
      return { tasks: Object.values(nextProps.tasks) };
    }
    return null;
  }

  render() {
    return (
      <React.Fragment>

        <div>
          <table className="table table-striped table-responsive-md">
            <thead>
              <tr>
                <th scope="col">Task Title</th>
                <th scope="col">Tags</th>
                <th scope="col">Description</th>
                <th scope="col">Actions</th>
              </tr>
            </thead>
            <tbody>
              {
                this.state.tasks.map((task) => (
                  <TaskRow key={task.id} task={task} current_user={this.props.current_user}/>
                ))
              }
            </tbody>
          </table>

        </div>
      </React.Fragment>
    );
  }
}

export default TaskIndex
