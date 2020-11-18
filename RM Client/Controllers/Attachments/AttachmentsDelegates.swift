import UIKit
import AVFoundation
import AVKit

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
        
        //id файла
        let attachmentID: Int = (self.selectTask?.attachments[indexPath.row].id)!
        
        let fileName: String = (self.selectTask?.attachments[indexPath.row].fileName)!
        
        //ссылка на файл
        let linkString = "https://\(user):\(password)@\(server)/attachments/download/\(attachmentID)/\(fileName)"
        
        if let fileURL = URL(string: (self.selectTask?.attachments[indexPath.row].fileName!)!){
            let fileUTI = UTI(withExtension: fileURL.pathExtension)
            switch fileUTI {
           
            case .pdf:
                // открытие пдф в сафари
                guard let url = URL(string: linkString) else { return }
                UIApplication.shared.open(url)
                
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFAttachmentVC") as! PDFAttachmentViewController
//                vc.pdfLink = linkString
//                self.present(vc, animated: true, completion: nil)
                
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

                // открытие ссылки в браузере
//                guard let url = URL(string: linkString) else { return }
//                UIApplication.shared.open(url)
                
                // открытие ссылки в плеере
//                let videoURL = URL(string: "https://sample-videos.com/video123/mp4/480/big_buck_bunny_480p_5mb.mp4")
                let videoURL = URL(string: linkString)
                let player = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
                
            case .docx, .doc:
                print("add dox")
                
            default:
                print("default")
            }
            self.attachmentsView.showContent()
        }
    }
}
