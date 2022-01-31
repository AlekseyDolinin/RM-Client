import UIKit
import SafariServices
//import AVFoundation
//import AVKit


extension AttachmentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (task?.attachments.count)!
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellAttachment = tableView.dequeueReusableCell(withIdentifier: "CellAttachment", for: indexPath) as! CellAttachment
        cellAttachment.attachment = task?.attachments[indexPath.row]
        cellAttachment.setCell()
        return cellAttachment
    }
    
    ///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Tasks", bundle: nil).instantiateViewController(withIdentifier: "PDFAttachmentVC") as! AttachmentViewController
        vc.link = (self.task?.attachments[indexPath.row].contentURL)!
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let headers: [String: String]? = API.shared.apikey.isEmpty ? nil : ["X-Redmine-API-Key": API.shared.apikey]
//        let linkString = (self.task?.attachments[indexPath.row].contentURL)!
//        guard let url = URL(string: linkString) else {return}
        
//        do {
//            let req: URLRequest = try URLRequest(url: url, method: .get, headers: headers)
//            print(req)
//            let vc = SafariViewController(url: req.url!, configuration: SFSafariViewController.Configuration())
//            present(vc, animated: true)
//        } catch _ {
//            print(12)
//        }
                
//        do {
//            _ = try wk.load(URLRequest(url: url, method: .get, headers: headers))
//        } catch {
//            print(error)
//        }
    }
    
}
