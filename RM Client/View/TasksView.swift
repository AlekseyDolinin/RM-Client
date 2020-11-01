import UIKit

class TasksView: UIView {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableTasks: UITableView!
    @IBOutlet weak var collectionStatusButton: UICollectionView!
    @IBOutlet weak var countAllTasks: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    func configure() {
        
        hideContent()
        
    }
    
    func hideContent() {
        topView.alpha = 0
        tableTasks.alpha = 0
        loader.startAnimating()
    }
    
    func showContent() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.topView.alpha = 1
            self?.tableTasks.alpha = 1
        }
        loader.stopAnimating()
    }
    
    func reloadContent() {
        UIView.transition(with: tableTasks, duration: 0.35, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.tableTasks.reloadData()
        })
        collectionStatusButton.reloadData()
    }
}
