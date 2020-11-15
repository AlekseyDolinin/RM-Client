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
        
        let date = Date().convertStringToDate(type: .dateAndTimeOne, dataString: (selectTask?.attachments[indexPath.row].createdOn)!)
        cellAttachment.createdOnLabel.text = Date().convertDateToString(type: .dateAndTimeTwo, date: date)
        
        return cellAttachment
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let filename: NSString = (self.selectTask?.attachments[indexPath.row].content_type)! as NSString
        let pathExtention = filename.pathExtension
        let pathPrefix = filename.deletingLastPathComponent
        
        // изображение
        if pathPrefix == "image" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageAttachmentVC") as! ImageAttachmentViewController
            vc.attachmentID = (self.selectTask?.attachments[indexPath.row].id)!
            self.present(vc, animated: true, completion: nil)
        }
        
        // видео
        if pathPrefix == "video" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoAttachmentVC") as! VideoAttachmentViewController
            vc.attachmentID = (self.selectTask?.attachments[indexPath.row].id)!
            self.present(vc, animated: true, completion: nil)
        }
        
        // документ
        if pathExtention == "document" {

        }
    }
}
