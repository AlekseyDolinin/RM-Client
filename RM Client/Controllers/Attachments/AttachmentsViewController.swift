import UIKit
import WebKit

class AttachmentsViewController: UIViewController, WKNavigationDelegate {
        
    var attachmentsView: AttachmentsView! {
        guard isViewLoaded else {return nil}
        return (view as! AttachmentsView)
    }
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        attachmentsView.tableAttachments.delegate = self
        attachmentsView.tableAttachments.dataSource = self
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

