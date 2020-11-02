import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameProjectLabel: UILabel!
    @IBOutlet weak var idProjectLabel: UILabel!
    @IBOutlet weak var createdProjectLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
