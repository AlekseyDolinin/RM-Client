import UIKit

class TaskDetailView: UIView {

    @IBOutlet weak var tableDetailInfoTask: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var titleParentTask: UILabel!
    @IBOutlet weak var idParentTask: UILabel!
    
    @IBOutlet weak var backViewStatus: UIView!
    @IBOutlet weak var nameStatusLabel: UILabel!
    
    @IBOutlet weak var backViewPriorityLabel: UIView!
    @IBOutlet weak var namePriorityLabel: UILabel!
    
    @IBOutlet weak var backViewSequenceLabel: UIView!
    @IBOutlet weak var nameSequenceLabel: UILabel!
    
    @IBOutlet weak var nameProjectLabel: UILabel!
    @IBOutlet weak var idTaskLabel: UILabel!
    @IBOutlet weak var nameTrackerLabel: UILabel!
    @IBOutlet weak var subjectTaskLabel: UILabel!
    
    @IBOutlet weak var stackParentInfo: UIStackView!    
    
    func configure() {
        
        backViewStatus.layer.cornerRadius = backViewStatus.frame.height / 2
        backViewPriorityLabel.layer.cornerRadius = backViewPriorityLabel.frame.height / 2
        backViewSequenceLabel.layer.cornerRadius = backViewSequenceLabel.frame.height / 2
        
        let showParenTaskTap = UITapGestureRecognizer(target: self, action: #selector(showParenTask))
        stackParentInfo.isUserInteractionEnabled = true
        stackParentInfo.addGestureRecognizer(showParenTaskTap)
    }
    
    func setParametersHeader(_ task: Task) {
        
        nameStatusLabel.text = task.status
        namePriorityLabel.text = task.priority
        
        for field in task.customFields {
            if field.name == "Порядок" {
                nameSequenceLabel.text = String(field.value)
            }
        }
        
        nameProjectLabel.text = task.project
        idTaskLabel.text = "\(task.idTask):"
        nameTrackerLabel.text = task.tracker
        subjectTaskLabel.text = task.subject
        
        if task.parent == 0 {
            idParentTask.isHidden = true
            titleParentTask.isHidden = true
        } else {
            idParentTask.text = "#\(task.parent)"
        }
        
        for status in mainStore.state.statusTasks {
            if task.status == status.name {
                backViewStatus.backgroundColor = status.color
            }
        }
        
//        print("category:\(task.category)")
//        print("doneRatio:\(task.doneRatio)")
//        
//        print("~~~~~~~~~~~~~~~~~~")
//        
//        print("assignedTo:\(task.assignedTo)")
//        print("closedOn:\(task.closedOn)")
//        print("createdOn:\(task.createdOn)")
//        print("updatedOn:\(task.updatedOn)")
//        print("dueDate:\(task.dueDate)")
//        print("estimatedHours:\(task.estimatedHours)")
//        print("startDate:\(task.startDate)")
//        
//        print("~~~~~~~~~~~~~~~~~~")
//        
//        print("isPrivate:\(task.isPrivate)")
//        print("description:\(task.description)")
        
    }

    
    @objc func showParenTask() {
        print("showParenTask")
    }
    
    
}
