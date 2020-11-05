import UIKit

class TasksViewController: UIViewController {

    var tasksView: TasksView! {
        guard isViewLoaded else {return nil}
        return (view as! TasksView)
    }
    
    var listFilteredTasks = [Task]()
    
    let rootVC = RootTasksViewController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tasksView.emptyView.isHidden = true
        
        tasksView.configure()
        
        tasksView.tableTasks.delegate = self
        tasksView.tableTasks.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTasks), name: NSNotification.Name(rawValue: "reloadTasks"), object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if !listFilteredTasks.isEmpty {
            tasksView.emptyView.isHidden = true
        } else {
            tasksView.emptyView.isHidden = false
        }
    }
    
    @objc func reloadTasks(_ notification: NSNotification) {
        listFilteredTasks = (notification.userInfo?["tasks"] as? [Task])!
        if listFilteredTasks.isEmpty {
            tasksView.emptyView.isHidden = false
        } else {
            tasksView.emptyView.isHidden = true
        }
        tasksView.tableTasks.reloadData()
    }
}
