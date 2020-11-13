import UIKit
import GPVideoPlayer

class DetailAttachmentViewController: UIViewController {

    var detailAttachmentView: DetailAttachmentView! {
        guard isViewLoaded else {return nil}
        return (view as! DetailAttachmentView)
    }

    var attachment: Attachment?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailAttachmentView.configure()
        checkTypeAttachment()
        
    }
    
    func checkTypeAttachment() {
        if attachment == nil {
            print("Attachment == nil")
            return
        }
        let attach: Attachment = attachment!
        let filename: NSString = attach.content_type! as NSString
        let pathExtention = filename.pathExtension
        let pathPrefix = filename.deletingLastPathComponent
        
        // изображение
        if pathPrefix == "image" {
            let idAttachment = (attachment!.id)!
            API.shared.getAttachmentImage(idAttachment: idAttachment) { (image) in
                self.setScrollViewImage(image: image)
            }
        }
        
        // документ
        if pathExtention == "document" {

        }
        
        // видео
        if pathPrefix == "video" {
            
            
////            https://a.dolinin:Nfkkby9890@dev.labmedia.su/attachments/download/143924
//
////            https://dev.labmedia.su/attachments/download/144099/316CB254-C1C7-4588-A5B0-2FDCCF21B97F.MP4
//
////            "https://a.dolinin:Nfkkby9890@dev.labmedia.su/attachments/download/144099/316CB254-C1C7-4588-A5B0-2FDCCF21B97F.MP4"

            
//            //1. Create a URL
//            if let url = URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4") {
//                print(url)
//                //2. Create AVPlayer object
//                let asset = AVAsset(url: url)
//                let playerItem = AVPlayerItem(asset: asset)
//                let player = AVPlayer(playerItem: playerItem)
//
//                //3. Create AVPlayerLayer object
//                let playerLayer = AVPlayerLayer(player: player)
//                playerLayer.frame = detailAttachmentView.backViewForImage.bounds //bounds of the view in which AVPlayer should be displayed
//                playerLayer.videoGravity = .resizeAspectFill
//
//                //4. Add playerLayer to view's layer
//                detailAttachmentView.backViewForImage.layer.addSublayer(playerLayer)
//
//                //5. Play Video
//                player.play()
//            }
            
            
            
            
            if let player = GPVideoPlayer.initialize(with: self.view.bounds) {
               detailAttachmentView.backViewForImage.addSubview(player)
                
//                let url = URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")!
                
                let url = URL(string: "https://a.dolinin:Nfkkby9890@dev.labmedia.su/attachments/download/144099/316CB254-C1C7-4588-A5B0-2FDCCF21B97F.MP4")!
                
                player.loadVideo(with: url)
                
                player.isToShowPlaybackControls = true
                
                player.isMuted = false
                
                player.playVideo()
                
                
                
            }
            
            

            
            
        }
    }

    
    @IBAction func closeModalView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

