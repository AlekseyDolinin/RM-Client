import UIKit

class PDFAttachmentViewController: UIViewController {

    var pdfAttachmentView: PDFAttachmentView! {
        guard isViewLoaded else {return nil}
        return (view as! PDFAttachmentView)
    }

    var pdfLink = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("pdfLink: \(pdfLink)")
        
        
//        let url: URL! = URL(string: pdfLink)
//        pdfAttachmentView.webView.load(URLRequest(url: url))
        
//        // открытие пдф в сафари
        guard let url = URL(string: pdfLink) else { return }
        UIApplication.shared.open(url)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        
    }
    
    @IBAction func closeModalView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}
