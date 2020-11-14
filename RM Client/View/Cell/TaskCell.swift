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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 8
        
        sequenceView.layer.cornerRadius = sequenceView.frame.height / 2
        priorityView.layer.cornerRadius = priorityView.frame.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
