import UIKit

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        taskCell.projectNameLabel.text = listFilteredTasks[indexPath.row].project
        taskCell.idTaskLabel.text = "#\(listFilteredTasks[indexPath.row].id): "
        taskCell.trackerLabel.text = listFilteredTasks[indexPath.row].tracker
        taskCell.nameTaskLabel.text = listFilteredTasks[indexPath.row].subject
        taskCell.nameAuthorTaskLabel.text = listFilteredTasks[indexPath.row].author
        taskCell.priorityLabel.text = listFilteredTasks[indexPath.row].priority
        
//        print(listFilteredTasks[indexPath.row].attachments)
        
        if listFilteredTasks[indexPath.row].attachments.isEmpty {
            taskCell.iconAttachFile.isHidden = true
        } else {
            taskCell.iconAttachFile.isHidden = false
        }
        
        for field in listFilteredTasks[indexPath.row].customFields {
            if field.name == "Порядок" {
                taskCell.sequenceLabel.text = String(field.value)
            }
        }
        
        let date = Date().convertStringToDate(dataString: listFilteredTasks[indexPath.row].createdOn)
        taskCell.createdDateLabel.text = Date().convertDateToString(date: date)
        
        
        // дозагрузка задач
        if indexPath.row == listFilteredTasks.count - 1 { // last cell
            print("подзагрузка")
            if rootVC.totalTasks > listFilteredTasks.count { // more items to fetch
                rootVC.offset = RootTasksViewController.shared.offset + 1
                rootVC.getTasks(offset: rootVC.offset)
            }
        }
        
        return taskCell
    }
}
