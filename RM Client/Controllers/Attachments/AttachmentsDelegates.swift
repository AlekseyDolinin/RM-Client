import UIKit
import AVFoundation
import AVKit

extension AttachmentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (task?.attachments.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellAttachment = tableView.dequeueReusableCell(withIdentifier: "CellAttachment", for: indexPath) as! CellAttachment
        
        cellAttachment.fileNameLabel.text = task?.attachments[indexPath.row].fileName
        
        let KB = Convert.convertByteToMb(valueByte: (task?.attachments[indexPath.row].filesize)!)
        cellAttachment.filesizeLabel.text = KB
        
        cellAttachment.authorLabel.text = task?.attachments[indexPath.row].author
        cellAttachment.createdOnLabel.text = task?.attachments[indexPath.row].createdOn
        cellAttachment.previewImageView.image = task?.attachments[indexPath.row].thumbnailImage
        
        let date = Date().convertStringToDate(type: .dateAndTimeOne, dataString: (task?.attachments[indexPath.row].createdOn)!)
        cellAttachment.createdOnLabel.text = Date().convertDateToString(type: .dateAndTimeTwo, date: date)
        
        return cellAttachment
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //id файла
        let attachmentID: Int = (self.task?.attachments[indexPath.row].id)!
        
        let fileName: String = (self.task?.attachments[indexPath.row].fileName)!
        
        //ссылка на файл
//        let linkString = "https://\(user):\(password)@\(server)/attachments/download/\(attachmentID)/\(fileName)"
        
        if let fileURL = URL(string: (self.task?.attachments[indexPath.row].fileName!)!){
            let fileUTI = UTI(withExtension: fileURL.pathExtension)
            
            switch fileUTI {
           
            case .pdf:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFAttachmentVC") as! PdfAttachmentViewController
//                vc.pdfLink = linkString
                self.present(vc, animated: true, completion: nil)
                
            case .jpeg, .png, .tiff:
                print("jpg")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageAttachmentVC") as! ImageAttachmentViewController
                vc.attachmentID = attachmentID
                vc.typeContent = "image"
                self.present(vc, animated: true, completion: nil)
            
            case .gif:
                print("gif")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageAttachmentVC") as! ImageAttachmentViewController
                vc.attachmentID = attachmentID
                vc.typeContent = "gif"
                self.present(vc, animated: true, completion: nil)
            
            case .html:
                print("html")
            
            case .quickTimeMovie, .mpeg, .mp4:
                
                // открытие ссылки в плеере
//                let videoURL = URL(string: "https://sample-videos.com/video123/mp4/480/big_buck_bunny_480p_5mb.mp4")
//                print(linkString)
//                let player = AVPlayer(url: URL(string: linkString)!)
                let playerViewController = AVPlayerViewController()
//                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
                
            case .docx, .doc:
                print("add dox")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFAttachmentVC") as! PdfAttachmentViewController
//                vc.pdfLink = linkString
                self.present(vc, animated: true, completion: nil)
            default:
                print("default")
            }
            self.attachmentsView.showContent()
        }
    }
}
