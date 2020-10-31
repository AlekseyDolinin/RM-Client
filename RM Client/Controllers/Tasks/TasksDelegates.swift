import UIKit

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        taskCell.nameLabel.text = "\(indexPath.row + 1) " + listTasks[indexPath.row].subject
        taskCell.descriptionLabel.text = listTasks[indexPath.row].description
        taskCell.createdOnLabel.text = listTasks[indexPath.row].createdOn
        taskCell.statusLabel.text = String(listTasks[indexPath.row].status)
        
        
        
        
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
