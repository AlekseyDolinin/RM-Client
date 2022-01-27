import UIKit

extension RootTasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCurrentTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
            
        return taskCell
    }
    
    
    func tableView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Parse.listTasksStatuses.count
    }

}
