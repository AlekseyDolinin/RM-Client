import UIKit

class CellOther: UITableViewCell {

    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleCellLabel.text = "Дополнительно".uppercased()
        titleCellLabel.addCharacterSpacing(kernValue: 1.5)
    }

}
