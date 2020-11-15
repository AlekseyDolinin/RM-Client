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
    
    func checkTypeAttachment() {
        for attachment in selectTask!.attachments {
            
            let filename: NSString = attachment.content_type! as NSString
            let pathExtention = (filename.pathExtension).lowercased()
            let pathPrefix = (filename.deletingLastPathComponent).lowercased()
            
            // изображение
            if pathPrefix == "image" {
                
                attachment.thumbnailImage = Attach.type.image.image
                
                // если есть ссылка на превью
                if attachment.thumbnail_url != "" {
                    // скачивание превью
                    let id: Int = attachment.id!
                    DispatchQueue.main.async {
                        API.shared.getImage(endPoint: "/attachments/thumbnail/\(id)") { (thumbnail) in
                            print(thumbnail)
                            attachment.thumbnailImage = thumbnail
                            self.attachmentsView.showContent()
                        }
                    }
                }
            } else
            
            // видео
            if pathPrefix == "video" {
                attachment.thumbnailImage = Attach.type.video.image

            } else {
            // документ
                pathExtention == "document"
                attachment.thumbnailImage = Attach.type.document.image
            }
            
            self.attachmentsView.showContent()
        }
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

