//import UIKit
//
//extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listProjects.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
//        
//        projectCell.nameLabel.text = "\(indexPath.row + 1) " + listProjects[indexPath.row].name
//        
//        projectCell.descriptionLabel.text = listProjects[indexPath.row].description
//        projectCell.createdOnLabel.text = listProjects[indexPath.row].created_on
//        projectCell.statusLabel.text = String(listProjects[indexPath.row].status)
//        
//        if indexPath.row == listProjects.count - 1 { // last cell
//            print("подзагрузка")
//            if totalProjects > listProjects.count { // more items to fetch
//                offset = offset + 1
//                getProjects(offset: offset)
//            }
//        }
//        return projectCell
//    }
// 
//}
