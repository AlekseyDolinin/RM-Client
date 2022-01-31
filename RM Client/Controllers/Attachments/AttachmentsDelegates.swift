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
        let vc = UIStoryboard(name: "Tasks", bundle: nil).instantiateViewController(withIdentifier: "AttachmentViewController") as! AttachmentViewController
        vc.link = (self.task?.attachments[indexPath.row].contentURL)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
