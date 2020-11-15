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
        
        let filename: NSString = (self.selectTask?.attachments[indexPath.row].content_type)! as NSString
        let pathExtention = (filename.pathExtension).lowercased()
        let pathPrefix = (filename.deletingLastPathComponent).lowercased()
        
        // изображение
        if pathPrefix == "image" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageAttachmentVC") as! ImageAttachmentViewController
            vc.attachmentID = (self.selectTask?.attachments[indexPath.row].id)!
            self.present(vc, animated: true, completion: nil)
        }
        
        // видео
        if pathPrefix == "video" {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoAttachmentVC") as! VideoAttachmentViewController
//            vc.attachmentID = (self.selectTask?.attachments[indexPath.row].id)!
//            self.present(vc, animated: true, completion: nil)
            
            let attachmentID: Int = (self.selectTask?.attachments[indexPath.row].id)!
            
            let user = UserDefaults.standard.dictionary(forKey: "userAuthData")!["user"] as! String
            let password = UserDefaults.standard.dictionary(forKey: "userAuthData")!["password"] as! String
            let server = UserDefaults.standard.dictionary(forKey: "userAuthData")!["server"] as! String
            
            let linkString = "https://\(user):\(password)@\(server)/attachments/download/\(attachmentID)"
            print(linkString)
//            guard let url = URL(string: linkString) else { return }
//            UIApplication.shared.open(url)
            
            let videoURL = URL(string: "https://sample-videos.com/video123/mp4/480/big_buck_bunny_480p_5mb.mp4")
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
        
        // документ
        if pathExtention == "document" {

        }
    }
}
