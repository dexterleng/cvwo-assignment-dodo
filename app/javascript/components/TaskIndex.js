import React from "react"
import TaskRow from './TaskRow';
class TaskIndex extends React.Component {
  state = {
    tasks: [],
    tags: [],
    highlighted: false
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    if (nextProps.tasks !== prevState.tasks){
      return {
        tasks: Object.values(nextProps.tasks),
        tags: nextProps.tags,
      };
    }
    return null;
  }  

  handleTagFilter = (tag) => {
    this.setState({ highlighted: tag });
  }

  render() {
    const taskFilter = this.state.highlighted === false ? (x) => true : (task) => task.tags.some(tag => tag.name === this.state.highlighted);
    const tasks = this.state.tasks.filter(taskFilter);
    return (
      <React.Fragment>
        <div>
          <ul>
            <li>
              <FilterButton onClick={() => this.handleTagFilter(false)} highlighted={this.state.highlighted} id={false}>Show All</FilterButton>
            </li>
            {
              this.state.tags.map((tag) => (
                <li key={tag}>
                  <FilterButton onClick={() => this.handleTagFilter(tag)} highlighted={this.state.highlighted} id={tag}>{tag}</FilterButton>
                </li>
              ))
            }
          </ul>
        </div>

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
                tasks.map((task) => (
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

const FilterButton = (props) => {  
  return (
    <button onClick={props.onClick} className={`btn ${ props.id === props.highlighted ? "btn-success" : "btn-warning" }`}>{props.children}</button>
  );
}

export default TaskIndex
