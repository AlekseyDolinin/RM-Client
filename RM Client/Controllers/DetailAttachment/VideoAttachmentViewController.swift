import UIKit
import GPVideoPlayer

class VideoAttachmentViewController: UIViewController {

    var videoAttachmentView: VideoAttachmentView! {
        guard isViewLoaded else {return nil}
        return (view as! VideoAttachmentView)
    }

    var attachmentID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoAttachmentView.configure()
        loadVideo()
    }
    
    func loadVideo() {
        API.shared.getImage(endPoint: "/attachments/download/\(attachmentID)") { (image) in

            
            
            
            
        }
    }
    
    @IBAction func closeModalView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
