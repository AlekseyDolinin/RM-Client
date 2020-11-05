import UIKit

extension RootTasksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainStore.state.statusTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cellStatus = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCell.reuseIdentifier, for: indexPath) as? StatusCell {
            
            cellStatus.nameStatus.text = mainStore.state.statusTasks[indexPath.row].name
            
            let arrayTasks: [Task] = mainStore.state.statusTasks[indexPath.row].arrayTasks
            cellStatus.badgeLabel.text = String(arrayTasks.count)
            
            
            let currentColor = mainStore.state.statusTasks[indexPath.row].color
            cellStatus.backView.layer.borderColor = currentColor.cgColor
            
//            cellStatus.badgeView.backgroundColor = currentColor
            
            cellStatus.badgeView.backgroundColor = currentColor.darker(by: 15)
            
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
