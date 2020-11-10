import UIKit

class CellOther: UITableViewCell {

    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleCellLabel.text = "ДОПОЛНИТЕЛЬНО"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
