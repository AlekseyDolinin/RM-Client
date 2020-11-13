import UIKit

class AttachmentsViewController: UIViewController {
    
    var attachmentsView: AttachmentsView! {
        guard isViewLoaded else {return nil}
        return (view as! AttachmentsView)
    }
    
    var selectTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attachmentsView.tableAttachments.delegate = self
        attachmentsView.tableAttachments.dataSource = self
        
        attachmentsView.configure()
        checkTypeAttachment()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func checkTypeAttachment() {
        for attachment in selectTask!.attachments {
            
            let filename: NSString = attachment.content_type! as NSString
            let pathExtention = filename.pathExtension
            let pathPrefix = filename.deletingLastPathComponent
            
            // изображение
            if pathPrefix == "image" {
                // если есть ссылка на превью
                if attachment.thumbnail_url != "" {
                    // скачивание превью
                    API.shared.getAttachmentThumbnail(idAttachment: attachment.id!) { (thumbnail) in
                        attachment.thumbnailImage = thumbnail
                        self.attachmentsView.tableAttachments.reloadData()
                    }
                }
            }
            // документ
            if pathExtention == "document" {
                attachment.thumbnailImage = Attach.type.document.image
            }
            // видео
            if pathPrefix == "video" {
                attachment.thumbnailImage = Attach.type.video.image
            }
        }
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

