import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var sequenceView: UIView!
    @IBOutlet weak var sequenceLabel: UILabel!
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var idTaskLabel: UILabel!
    @IBOutlet weak var trackerLabel: UILabel!
    @IBOutlet weak var nameTaskLabel: UILabel!
    @IBOutlet weak var nameAuthorTaskLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var iconAttachFile: UIImageView!
    
    var task: Task!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    func setCell() {
        
        projectNameLabel.text = task.project
        idTaskLabel.text = "#\(task.idTask): "
        trackerLabel.text = task.tracker
        nameTaskLabel.text = task.subject
        nameAuthorTaskLabel.text = task.author
        priorityLabel.text = task.priority
        projectNameLabel.text = task.project
        idTaskLabel.text = "#\(task.idTask): "
        trackerLabel.text = task.tracker
        nameTaskLabel.text = task.subject
        
        if task.attachments.isEmpty {
            iconAttachFile.isHidden = true
        } else {
            iconAttachFile.isHidden = false
        }
        
        for field in task.customFields {
            if field.id == 1 {
                sequenceLabel.text = String(field.value)
            }
        }
        
        let date = Date().convertStringToDate(type: .dateAndTimeOne, dataString:task.createdOn)
        createdDateLabel.text = Date().convertDateToString(type: .dateAndTimeTwo, date: date)
        
    }
    
    
    
}

extension TaskCell {
    
    func setUI() {
        backView.layer.cornerRadius = 8
        sequenceView.layer.cornerRadius = sequenceView.frame.height / 2
        priorityView.layer.cornerRadius = priorityView.frame.height / 2
    }
}
