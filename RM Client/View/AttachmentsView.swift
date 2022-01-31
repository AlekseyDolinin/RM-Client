import UIKit

class AttachmentsView: UIView {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableAttachments: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
}


extension AttachmentsView {
    
    func setUI() {
        loader.stopAnimating()
        titleLabel.text = "Файлы"
    }
}
