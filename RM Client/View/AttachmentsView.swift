import UIKit

class AttachmentsView: UIView {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableAttachments: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure() {
        
        titleLabel.text = "Файлы"

    }

}

