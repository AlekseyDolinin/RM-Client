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
            
            if let fileURL = URL(string: attachment.fileName!){
                let fileUTI = UTI(withExtension: fileURL.pathExtension)
                switch fileUTI {
                case .pdf:
                    print("add PDF Options")
                    attachment.thumbnailImage = Attach.type.document.image
                case .jpeg, .png, .tiff:
                    print("add jpg Options")
                    attachment.thumbnailImage = Attach.type.image.image
                case .gif:
                    print("add gif options")
                case .html:
                    print("add html options")
                case .quickTimeMovie, .mpeg, .mp4:
                    print("video")
                    attachment.thumbnailImage = Attach.type.video.image
                case .docx, .doc:
                    print("add dox options")
                    attachment.thumbnailImage = Attach.type.document.image
                default:
                    print("default")
                }
                self.attachmentsView.showContent()
            }
        }
    }
    
//    func loadPreview() {
//
//            // если есть ссылка на превью
//            if attachment.thumbnail_url != "" {
//                // скачивание превью
//                let id: Int = attachment.id!
//                DispatchQueue.main.async {
//                    API.shared.getImage(endPoint: "/attachments/thumbnail/\(id)") { (thumbnail) in
//                        print(thumbnail)
//                        attachment.thumbnailImage = thumbnail
//                        self.attachmentsView.showContent()
//                    }
//                }
//            }
//    }
    
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

