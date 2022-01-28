import UIKit

class AttachmentsViewController: UIViewController {
    
    var attachmentsView: AttachmentsView! {
        guard isViewLoaded else {return nil}
        return (view as! AttachmentsView)
    }
    
    var task: Task?
    
//    let user = UserDefaults.standard.dictionary(forKey: "userAuthData")!["user"] as! String
//    let password = UserDefaults.standard.dictionary(forKey: "userAuthData")!["password"] as! String
//    let server = UserDefaults.standard.dictionary(forKey: "userAuthData")!["server"] as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attachmentsView.tableAttachments.delegate = self
        attachmentsView.tableAttachments.dataSource = self
        attachmentsView.configure()
        checkTypeAttachment()
    }
    
    func checkTypeAttachment() {
        for attachment in task!.attachments {
            
            if let fileURL = URL(string: attachment.fileName!){
                let fileUTI = UTI(withExtension: fileURL.pathExtension)
                switch fileUTI {
                    
                case .pdf:
                    attachment.thumbnailImage = Attach.type.document.image
                    
                case .jpeg, .png, .tiff:
                    attachment.thumbnailImage = Attach.type.image.image
                    
                case .gif:
                    attachment.thumbnailImage = Attach.type.image.image
                    
                case .html:
                    print("html")
                    
                case .quickTimeMovie, .mpeg, .mp4:
                    attachment.thumbnailImage = Attach.type.video.image
                    
                case .docx, .doc:
                    attachment.thumbnailImage = Attach.type.document.image
                    
                default:
                    print("default")
                }
                self.attachmentsView.showContent()
            }
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

