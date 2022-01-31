import UIKit

class CellAttachment: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var filesizeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var removeAttachmentButtun: UIButton!
    
    var attachment: Attachment!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    ///
    func setCell(){
        setContent()
        setSize()
        setDate()
        setPreview()
    }
    
    func setContent() {
        fileNameLabel.text = attachment.fileName
        authorLabel.text = attachment.author
        createdOnLabel.text = attachment.createdOn
        
//        previewImageView.image = attachment.thumbnailImage
        
    }
    
    ///
    func setSize() {
        filesizeLabel.text = Convert.convertByteToMb(valueByte: attachment.filesize)
    }
    
    ///
    func setDate() {
        let date = Date().convertStringToDate(type: .dateAndTimeOne, dataString: attachment.createdOn)
        createdOnLabel.text = Date().convertDateToString(type: .dateAndTimeTwo, date: date)
    }
    
    ///
    func setPreview() {
        
        switch attachment.contentURL.fileExtension() {
        case "png", "jpg", "jpeg", "svg":
            previewImageView.image = UIImage(named: "att_Image")!
        case "key", "numbers", "pages", "rtf":
            previewImageView.image = UIImage(named: "att_Document")!
        case "MP4":
            previewImageView.image = UIImage(named: "att_Video")!
        default:
            previewImageView.image = UIImage(named: "att_File")!
            print("не обрабатывается: \(attachment.contentURL.fileExtension())")
        }
        
    }
    
}

extension CellAttachment {
    
    func setUI() {
        previewImageView.layer.cornerRadius = 4
        previewImageView.backgroundColor = ._backgroundNormal
    }
}

extension String {

    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
}
