import UIKit

class CellHistory: UITableViewCell {

    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleCellLabel.text = "История".uppercased()
        titleCellLabel.addCharacterSpacing(kernValue: 1.5)
    }

}
