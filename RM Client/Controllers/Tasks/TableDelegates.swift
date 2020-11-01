import UIKit

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        taskCell.projectNameLabel.text = listFilteredTasks[indexPath.row].project
        taskCell.priorityLabel.text = "test"
        taskCell.idTaskLabel.text = "#\(listFilteredTasks[indexPath.row].id): "
        taskCell.trackerLabel.text = listFilteredTasks[indexPath.row].tracker
        taskCell.nameTaskLabel.text = listFilteredTasks[indexPath.row].subject
        taskCell.nameAuthorTaskLabel.text = listFilteredTasks[indexPath.row].author
        taskCell.createdDateLabel.text = listFilteredTasks[indexPath.row].createdOn

        
//        if indexPath.row == listTasks.count - 1 { // last cell
//            print("подзагрузка")
//            if totalTasks > listTasks.count { // more items to fetch
//                offset = offset + 1
//                getTasks(offset: offset)
//            }
//        }
        
        return taskCell
    }
}
