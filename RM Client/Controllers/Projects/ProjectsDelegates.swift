import UIKit

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        
        projectCell.project = listProjects[indexPath.row]
        projectCell.setCell()
        
//        if indexPath.row == listProjects.count - 1 { // last cell
//            print("подзагрузка")
//            if ProjectsViewController.totalProjects > listProjects.count { // more items to fetch
//                offset = offset + 1
//                getProjects(offset: offset)
//            }
//        }
        return projectCell
    }
    
}

