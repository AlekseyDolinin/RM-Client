import UIKit
import GPVideoPlayer

class DetailAttachmentViewController: UIViewController {

    var detailAttachmentView: DetailAttachmentView! {
        guard isViewLoaded else {return nil}
        return (view as! DetailAttachmentView)
    }

    var attachmentID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailAttachmentView.configure()
        loadImage()
    }
    
    func loadImage() {
        API.shared.getImage(endPoint: "/attachments/download/\(attachmentID)") { (image) in
            self.setScrollViewImage(image: image)
            self.detailAttachmentView.loader.stopAnimating()
        }
    }
    
    @IBAction func closeModalView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

