import UIKit

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCurrentTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        taskCell.task = self.listCurrentTasks[indexPath.row]
        taskCell.setCell()
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Tasks", bundle: nil).instantiateViewController(withIdentifier: "TaskDetailVC") as! TaskDetailViewController
        vc.task = listCurrentTasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
