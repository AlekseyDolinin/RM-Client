import UIKit

class ImageAttachmentViewController: UIViewController, ImageViewZoomDelegate {

    var imageAttachmentView: ImageAttachmentView! {
        guard isViewLoaded else {return nil}
        return (view as! ImageAttachmentView)
    }

    var attachmentID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageAttachmentView.configure()
        loadImage()
    }
    
    func loadImage() {
        API.shared.getImage(endPoint: "/attachments/download/\(attachmentID)") { (image) in
            self.setScrollViewImage(image: image)
            self.imageAttachmentView.loader.stopAnimating()
        }
    }
    
    func setScrollViewImage(image: UIImage) {
        
        imageAttachmentView.backViewForImage.alpha = 0
        
        let viewHeight: CGFloat = self.view.bounds.size.height
        let viewWidth: CGFloat = self.view.bounds.size.width
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        let imageView = ImageViewZoom(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        imageView.setup()
        imageView.imageScrollViewDelegate = self
        imageView.imageContentMode = .aspectFit
        imageView.initialOffset = .center
        imageView.display(image: image)
        scrollView.addSubview(imageView)
        
        imageAttachmentView.backViewForImage.addSubview(scrollView)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.imageAttachmentView.backViewForImage.alpha = 1
        }
    }
    
    func imageScrollViewDidChangeOrientation(imageViewZoom: ImageViewZoom) {
        //        print("Did change orientation")
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        //        print("scrollViewDidEndZooming at scale \(scale)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print("scrollViewDidScroll at offset \(scrollView.contentOffset)")
    }
    
    @IBAction func closeModalView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
