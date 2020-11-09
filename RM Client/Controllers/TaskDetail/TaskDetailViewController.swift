import UIKit

class TaskDetailViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var titleParentTask: UILabel!
    @IBOutlet weak var idParentTask: UILabel!
    
    @IBOutlet weak var backViewStatusLabel: UIView!
    @IBOutlet weak var nameStatusLabel: UILabel!
    
    @IBOutlet weak var backViewPriorityLabel: UIView!
    @IBOutlet weak var namePriorityLabel: UILabel!
    
    @IBOutlet weak var backViewSequenceLabel: UIView!
    @IBOutlet weak var nameSequenceLabel: UILabel!
    
    @IBOutlet weak var nameProjectLabel: UILabel!
    @IBOutlet weak var idTaskLabel: UILabel!
    @IBOutlet weak var nameTrackerLabel: UILabel!
    @IBOutlet weak var subjectTaskLabel: UILabel!
    
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
                setParametersHeader(task)
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
    
    func setParametersHeader(_ task: Task) {
        
        backViewStatusLabel.layer.cornerRadius = backViewStatusLabel.frame.height / 2
        backViewPriorityLabel.layer.cornerRadius = backViewPriorityLabel.frame.height / 2
        backViewSequenceLabel.layer.cornerRadius = backViewSequenceLabel.frame.height / 2
        
        nameStatusLabel.text = task.status
        namePriorityLabel.text = task.priority
        
        for field in task.customFields {
            if field.name == "Порядок" {
                nameSequenceLabel.text = String(field.value)
            }
        }
        
        nameProjectLabel.text = task.project
        idTaskLabel.text = "\(task.id):"
        nameTrackerLabel.text = task.tracker
        subjectTaskLabel.text = task.subject
        
        if task.parent == 0 {
            idParentTask.isHidden = true
            titleParentTask.isHidden = true
        } else {
            idParentTask.text = "#\(task.parent)"
        }
        
        for status in mainStore.state.statusTasks {
            print(status.name)
            if task.status == status.name {
                print("СОВПАДЕНИЕ")
                backViewStatusLabel.backgroundColor = status.color
                backViewStatusLabel.layer.backgroundColor = status.color.cgColor
            }
        }
        
        print("category:\(task.category)")
        print("doneRatio:\(task.doneRatio)")
        
        print("~~~~~~~~~~~~~~~~~~")
        
        print("assignedTo:\(task.assignedTo)")
        print("closedOn:\(task.closedOn)")
        print("createdOn:\(task.createdOn)")
        print("updatedOn:\(task.updatedOn)")
        print("dueDate:\(task.dueDate)")
        print("estimatedHours:\(task.estimatedHours)")
        print("startDate:\(task.startDate)")
            
        print("~~~~~~~~~~~~~~~~~~")
        
        print("isPrivate:\(task.isPrivate)")
        print("description:\(task.description)")
        
        
        
    }
  
}
