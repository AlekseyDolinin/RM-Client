import UIKit

class DetailAttachmentViewController: UIViewController {

    var detailAttachmentView: DetailAttachmentView! {
        guard isViewLoaded else {return nil}
        return (view as! DetailAttachmentView)
    }

    var attachment: Attachment?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailAttachmentView.configure()
        checkTypeAttachment()
        
    }
    
    func checkTypeAttachment() {
        if attachment == nil {
            print("Attachment == nil")
            return
        }
        let attach: Attachment = attachment!
        let filename: NSString = attach.content_type! as NSString
        let pathExtention = filename.pathExtension
        let pathPrefix = filename.deletingLastPathComponent
        
        // изображение
        if pathPrefix == "image" {
            let idAttachment = (attachment!.id)!
            API.shared.getAttachmentImage(idAttachment: idAttachment) { (image) in
                self.setScrollViewImage(image: image)
            }
        }
        
        // документ
        if pathExtention == "document" {

        }
        
        // видео
        if pathPrefix == "video" {

        }
    }
    
    @IBAction func closeModalView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

