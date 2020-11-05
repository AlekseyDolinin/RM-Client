import UIKit

class TaskDetailViewController: UIViewController {

    var taskDetailView: TaskDetailView! {
        guard isViewLoaded else {return nil}
        return (view as! TaskDetailView)
    }
    
    var idSelectTask = Int()
    var selectTask: Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskDetailView.configure()
        
        for task in mainStore.state.userTasks {
            
            if task.id == idSelectTask {
                selectTask = task
                print(selectTask?.subject)
            }
        }
    }
  
}
