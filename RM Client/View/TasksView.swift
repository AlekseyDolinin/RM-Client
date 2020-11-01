import UIKit

class TasksView: UIView {
    
    @IBOutlet weak var tableTasks: UITableView!
    
    @IBOutlet weak var countAllTasks: UILabel!
    
    func configure() {
        
        countAllTasks.text = ""
        
    }

}
