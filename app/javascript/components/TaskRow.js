import React from "react"
import PropTypes from "prop-types"

class TaskRow extends React.Component {
  render () {
    const {task} = this.props;
    return (
      <React.Fragment>
        <tr>
          <th>
            {task.done ? <s>{task.title}</s> : task.title}
          </th>
          <td>
            <ul>
              {task.tags.map((tag) =>
                <li key={tag.id}>
                  <p>{tag.name}</p>
                </li>
              )}
            </ul>
          </td>
          <td>
            {task.desc}
          </td>
          <td>
            { !task.done ? 
              (
              <a href={`/tasks/${task.id}/done`} data-method="post">
                <button className="btn btn-success">Mark as done</button>
              </a>
              )
              :
              (
                <a href={`/tasks/${task.id}/undone`} data-method="post">
                  <button className="btn btn-warning">Mark as undone</button>
                </a>
              )
            }
            {
              <a href={`/tasks/${task.id}/edit`} data-method="get">
                <button className="btn btn-primary">
                  Edit
                </button>
              </a>
            }
            {
              <a href={`/tasks/${task.id}`} data-method="delete">
                <button className="btn btn-danger">
                  Delete
                </button>
              </a>
            }
          </td>
        </tr>
      </React.Fragment>
    );
  }
}

export default TaskRow
