import UIKit
import WebKit

class PdfAttachmentViewController: UIViewController  {

    var pdfAttachmentView: PDFAttachmentView! {
        guard isViewLoaded else {return nil}
        return (view as! PDFAttachmentView)
    }

    var pdfLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.shared.getPdf(link: pdfLink) { (dataPDF) in
            self.pdfAttachmentView.loader.stopAnimating()
            if let decodeData: Data = Data(base64Encoded: dataPDF.base64EncodedString(), options: NSData.Base64DecodingOptions.ignoreUnknownCharacters) {
                self.pdfAttachmentView.webView.load(decodeData, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: URL(fileURLWithPath: ""))
            }
        }
    }
    
    @IBAction func closeModalView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}
