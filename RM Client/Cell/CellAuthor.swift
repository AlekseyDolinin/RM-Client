import UIKit

class CellAuthor: UITableViewCell {

    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var nameAuthorLabel: UILabel!
    @IBOutlet weak var timingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleCellLabel.text = "Автор".uppercased()
        titleCellLabel.addCharacterSpacing(kernValue: 1.3)
    }

}
