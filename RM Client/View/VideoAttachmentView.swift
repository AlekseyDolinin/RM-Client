import UIKit

class VideoAttachmentView: UIView {
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    func configure() {
        loader.startAnimating()

    }

}

