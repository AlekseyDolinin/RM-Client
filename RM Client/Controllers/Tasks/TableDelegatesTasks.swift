//import UIKit
//
//extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listFilteredTasks.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
//        
//        taskCell.projectNameLabel.text = listFilteredTasks[indexPath.row].project
//        taskCell.idTaskLabel.text = "#\(listFilteredTasks[indexPath.row].idTask): "
//        taskCell.trackerLabel.text = listFilteredTasks[indexPath.row].tracker
//        taskCell.nameTaskLabel.text = listFilteredTasks[indexPath.row].subject
//        taskCell.nameAuthorTaskLabel.text = listFilteredTasks[indexPath.row].author
//        taskCell.priorityLabel.text = listFilteredTasks[indexPath.row].priority
//                
//        if listFilteredTasks[indexPath.row].attachments.isEmpty {
//            taskCell.iconAttachFile.isHidden = true
//        } else {
//            taskCell.iconAttachFile.isHidden = false
//        }
//        
//        for field in listFilteredTasks[indexPath.row].customFields {
//            if field.name == "Порядок" {
//                taskCell.sequenceLabel.text = String(field.value)
//            }
//        }
//        
//        let date = Date().convertStringToDate(type: .dateAndTimeOne, dataString: listFilteredTasks[indexPath.row].createdOn)
//        taskCell.createdDateLabel.text = Date().convertDateToString(type: .dateAndTimeTwo, date: date)
//        
////        // дозагрузка задач
////        if indexPath.row == listFilteredTasks.count - 1 { // last cell
////            print("подзагрузка")
////            if mainStore.state.userTasks.count > listFilteredTasks.count { // more items to fetch
////                rootVC.offset = RootTasksViewController.shared.offset + 1
////                StartViewController.shared.getTasks(offset: rootVC.offset)
////            }
////        }
//        
//        return taskCell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TaskDetailVC") as! TaskDetailViewController
//        vc.idSelectTask = listFilteredTasks[indexPath.row].idTask
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
