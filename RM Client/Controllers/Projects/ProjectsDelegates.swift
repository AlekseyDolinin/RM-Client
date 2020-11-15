import UIKit

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        
        projectCell.nameProjectLabel.text = listProjects[indexPath.row].name
        projectCell.idProjectLabel.text = "#\(listProjects[indexPath.row].idProject)"
        
        let date = Date().convertStringToDate(dataString: listProjects[indexPath.row].created_on)
        projectCell.createdProjectLabel.text = Date().convertDateToString(date: date)
        
        if let childCountProjects = listProjects[indexPath.row].childProjects?.count {
            projectCell.countChildProject.text = String(childCountProjects)
        } else {
            projectCell.countChildProject.isHidden = true
        }
        
        
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

