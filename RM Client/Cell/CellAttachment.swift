import UIKit

class CellAttachment: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var filesizeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var removeAttachmentButtun: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        previewImageView.layer.cornerRadius = 4
        previewImageView.backgroundColor = ._backgroundNormal
        previewImageView.image = Attach.type.file.image
    }

}
