import UIKit

extension TaskDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellDescription = tableView.dequeueReusableCell(withIdentifier: "CellDescription", for: indexPath) as! CellDescription
        
        
        return cellDescription
    }
    
    
    
    
    
    
    
    
}
