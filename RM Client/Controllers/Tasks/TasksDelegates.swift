import UIKit

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        taskCell.projectNameLabel.text = listTasks[indexPath.row].project
        taskCell.priorityLabel.text = "test"
        taskCell.idTaskLabel.text = "#\(listTasks[indexPath.row].id): "
        taskCell.trackerLabel.text = listTasks[indexPath.row].tracker
        taskCell.nameTaskLabel.text = listTasks[indexPath.row].subject
        taskCell.nameAuthorTaskLabel.text = listTasks[indexPath.row].author
        taskCell.createdDateLabel.text = listTasks[indexPath.row].createdOn

        
        if indexPath.row == listTasks.count - 1 { // last cell
            print("подзагрузка")
            if totalTasks > listTasks.count { // more items to fetch
                offset = offset + 1
                getTasks(offset: offset)
            }
        }
        return taskCell
    }
}
