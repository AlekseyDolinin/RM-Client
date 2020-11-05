import UIKit

class RootTasksView: UIView {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var collectionStatusButton: UICollectionView!
    @IBOutlet weak var countAllTasks: UILabel!
    
    func configure() {
//        hideContent()
    }
    
    func hideContent() {
        viewTop.alpha = 0
        scrollView.alpha = 0
        loader.startAnimating()
    }
    
    func showContent() {
        collectionStatusButton.reloadData()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewTop.alpha = 1
            self?.scrollView.alpha = 1
        }
        
        loader.stopAnimating()
    }
}
