import UIKit

extension RootTasksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlesStatusArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cellStatus = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCell.reuseIdentifier, for: indexPath) as? StatusCell {
            
            cellStatus.nameStatus.text = titlesStatusArray[indexPath.row]
            
            let currentColor = UIColor(named: colorsStatusArray[indexPath.row])
            cellStatus.backView.layer.borderColor = currentColor?.cgColor
            
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
