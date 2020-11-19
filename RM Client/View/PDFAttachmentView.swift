import UIKit
import WebKit
import PDFKit

class PDFAttachmentView: UIView {

    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    func configure() {
        loader.startAnimating()
        
    }
    
}

