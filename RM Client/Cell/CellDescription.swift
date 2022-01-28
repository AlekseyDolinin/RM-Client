import UIKit

class CellDescription: UITableViewCell {

    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var textDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleCellLabel.text = "Описание".uppercased()
        titleCellLabel.addCharacterSpacing(kernValue: 1.3)
    }

}
