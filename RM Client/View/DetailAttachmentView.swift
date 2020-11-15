import UIKit

class DetailAttachmentView: UIView {
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var backViewForImage: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    func configure() {
        loader.startAnimating()

    }

}

