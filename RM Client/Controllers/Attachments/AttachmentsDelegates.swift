import UIKit

extension AttachmentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectTask?.attachments.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellAttachment = tableView.dequeueReusableCell(withIdentifier: "CellAttachment", for: indexPath) as! CellAttachment

        cellAttachment.fileNameLabel.text = selectTask?.attachments[indexPath.row].fileName
        
        let KB = Convert.convertByteToMb(valueByte: (selectTask?.attachments[indexPath.row].filesize)!)
        cellAttachment.filesizeLabel.text = KB
        
        cellAttachment.authorLabel.text = selectTask?.attachments[indexPath.row].author
        cellAttachment.createdOnLabel.text = selectTask?.attachments[indexPath.row].createdOn
        cellAttachment.previewImageView.image = selectTask?.attachments[indexPath.row].thumbnailImage
        
        let date = Date().convertStringToDate(dataString: (selectTask?.attachments[indexPath.row].createdOn)!)
        cellAttachment.createdOnLabel.text = Date().convertDateToString(date: date)
        
        return cellAttachment
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailAttachmentVC") as! DetailAttachmentViewController
        vc.attachment = selectTask?.attachments[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
}
