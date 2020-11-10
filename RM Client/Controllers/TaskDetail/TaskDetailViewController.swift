import UIKit

class TaskDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var taskDetailView: TaskDetailView! {
        guard isViewLoaded else {return nil}
        return (view as! TaskDetailView)
    }
    
    var idSelectTask = Int()
    var selectTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskDetailView.configure()
        
        navigationController?.interactivePopGestureRecognizer!.delegate = self
        
        taskDetailView.tableDetailInfoTask.delegate = self
        taskDetailView.tableDetailInfoTask.dataSource = self
        
        for task in mainStore.state.userTasks {
            if task.id == idSelectTask {
                selectTask = task
                taskDetailView.setParametersHeader(task)
            }
        }
    }
    
    // авторесайз хедера таблицы
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let headerView = taskDetailView.tableDetailInfoTask.tableHeaderView else { return }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            taskDetailView.tableDetailInfoTask.tableHeaderView = headerView
            taskDetailView.tableDetailInfoTask.layoutIfNeeded()
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        print("BACK")
        navigationController?.popViewController(animated: true)
    }
  
}
