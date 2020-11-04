import UIKit

extension RootTasksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listStatusTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cellStatus = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCell.reuseIdentifier, for: indexPath) as? StatusCell {
            
            cellStatus.nameStatus.text = listStatusTasks[indexPath.row]["name"] as? String
            
            let arrayTasks: [Task] = listStatusTasks[indexPath.row]["tasks"] as! [Task]
            cellStatus.badgeLabel.text = String(arrayTasks.count)
            
            
            let currentColor = listStatusTasks[indexPath.row]["color"] as! UIColor
            cellStatus.backView.layer.borderColor = currentColor.cgColor
            
            cellStatus.badgeView.backgroundColor = currentColor
            cellStatus.badgeView.layer.borderColor = currentColor.cgColor
            
            // set current Cell Status
            if indexPath.row == currentIndexFilter {
                cellStatus.nameStatus.textColor = ._white
                cellStatus.backView.backgroundColor = currentColor
            } else {
                cellStatus.nameStatus.textColor = currentColor
                cellStatus.backView.backgroundColor = .clear
            }
            
            return cellStatus
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectFilterTasks(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
}
