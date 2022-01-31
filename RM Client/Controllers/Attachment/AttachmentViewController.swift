import UIKit
import WebKit

class AttachmentViewController: UIViewController  {

    var viewSelf: AttachmentView! {
        guard isViewLoaded else {return nil}
        return (view as! AttachmentView)
    }

    var link: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headers: [String: String]? = API.shared.apikey.isEmpty ? nil : ["X-Redmine-API-Key": API.shared.apikey]
        guard let url = URL(string: link) else {return}
        
        do {
            _ = try viewSelf.webView.load(URLRequest(url: url, method: .get, headers: headers))
        } catch {
            print(error)
        }
    }
    
    @IBAction func closeModalView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
