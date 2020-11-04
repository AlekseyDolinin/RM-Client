import UIKit

class TasksView: UIView {
    
    @IBOutlet weak var tableTasks: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    func configure() {
        
//        hideContent()
    }
    
//    func hideContent() {
//        emptyView.alpha = 0
//        tableTasks.alpha = 0
//    }
    
//    func showContent() {
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            self?.tableTasks.alpha = 1
//        }
//    }
    
//    func reloadContent() {
//        UIView.transition(with: tableTasks, duration: 0.35, options: .transitionCrossDissolve, animations: { [weak self] in
//            self?.tableTasks.reloadData()
//        })
//        collectionStatusButton.reloadData()
//    }
    
//    func stateEmtyView(_ alpha: CGFloat) {
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            self?.emptyView.alpha = alpha
//        }
//    }
}
