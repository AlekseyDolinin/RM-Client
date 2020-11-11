import UIKit

extension DetailAttachmentViewController: ImageViewZoomDelegate {
    
    func setScrollViewImage(image: UIImage) {
        
        detailAttachmentView.backView.alpha = 0
        
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

        detailAttachmentView.backView.addSubview(scrollView)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.detailAttachmentView.backView.alpha = 1
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
}
