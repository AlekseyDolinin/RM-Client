import UIKit
//import GPVideoPlayer
import AVFoundation
import AVKit

class VideoAttachmentViewController: UIViewController {

    var videoAttachmentView: VideoAttachmentView! {
        guard isViewLoaded else {return nil}
        return (view as! VideoAttachmentView)
    }

    var attachmentID = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoAttachmentView.configure()
//        loadVideo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        loadVideo()
        
        let videoURL = URL(string:  "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    
    
    func loadVideo() {
        
        let user = UserDefaults.standard.dictionary(forKey: "userAuthData")!["user"] as! String
        let password = UserDefaults.standard.dictionary(forKey: "userAuthData")!["password"] as! String
        let server = UserDefaults.standard.dictionary(forKey: "userAuthData")!["server"] as! String
        
        let linkString = "https://\(user):\(password)@\(server)/attachments/download/\(attachmentID)"
        let linkString2 = "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4"
        
        
        
//        guard let url = URL(string: linkString2) else { return }
//        UIApplication.shared.open(url)
        
//        if let player = GPVideoPlayer.initialize(with: self.view.bounds) {
//            self.videoAttachmentView.backViewForVideo.addSubview(player)
//            let url = URL(string: linkString2)!
////                let videoFilePath = Bundle.main.path(forResource: "video", ofType: "mp4")
////                let url2 = URL(fileURLWithPath: videoFilePath!)
//
//            player.loadVideo(with: url)
//            player.isToShowPlaybackControls = true
//            player.isMuted = true
//            player.playVideo()
//        }

        
        
        
//        API.shared.getVideo(endPoint: "/attachments/\(attachmentID)") { (dataVideo) in
//        API.shared.getVideo(endPoint: "/attachments/download/\(attachmentID)") { (dataVideo) in
//            print(dataVideo)
//        }
    }
    
    @IBAction func closeModalView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}
