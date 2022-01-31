import UIKit
import WebKit

class AttachmentsViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var wk: CustomWebView!
    
    var attachmentsView: AttachmentsView! {
        guard isViewLoaded else {return nil}
        return (view as! AttachmentsView)
    }
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wk.navigationDelegate = self
        
        attachmentsView.tableAttachments.delegate = self
        attachmentsView.tableAttachments.dataSource = self
    }
    
    func checkTypeAttachment() {
//        for attachment in task!.attachments {
//
//            if let fileURL = URL(string: attachment.fileName!){
//                let fileUTI = UTI(withExtension: fileURL.pathExtension)
//                switch fileUTI {
//
//                case .pdf:
//                    attachment.thumbnailImage = Attach.type.document.image
//
//                case .jpeg, .png, .tiff:
//                    attachment.thumbnailImage = Attach.type.image.image
//
//                case .gif:
//                    attachment.thumbnailImage = Attach.type.image.image
//
//                case .html:
//                    print("html")
//
//                case .quickTimeMovie, .mpeg, .mp4:
//                    attachment.thumbnailImage = Attach.type.video.image
//
//                case .docx, .doc:
//                    attachment.thumbnailImage = Attach.type.document.image
//
//                default:
//                    print("default")
//                }
//                self.attachmentsView.showContent()
//            }
//        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

