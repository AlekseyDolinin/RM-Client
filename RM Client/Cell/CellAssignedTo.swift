import UIKit

class CellAssignedTo: UITableViewCell {

    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleCellLabel.text = "Назначена".uppercased()
        titleCellLabel.addCharacterSpacing(kernValue: 1.3)
    }

}
