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
        
        let idAttachment = (selectTask?.attachments[indexPath.row].id)!
        
        API.shared.getImage(id: idAttachment) { (thumbnailImage) in
            cellAttachment.previewImageView.image = thumbnailImage
        }
        
        return cellAttachment
    }
}
