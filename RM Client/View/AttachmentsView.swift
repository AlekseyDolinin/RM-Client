import UIKit

class AttachmentsView: UIView {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableAttachments: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    func configure() {
        titleLabel.text = "Файлы"
        tableAttachments.isHidden = true
        loader.startAnimating()
    }

    func showContent() {
        tableAttachments.reloadData()
        tableAttachments.isHidden = false
        loader.stopAnimating()
    }
}

