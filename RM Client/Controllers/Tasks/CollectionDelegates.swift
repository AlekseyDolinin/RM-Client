import UIKit

extension RootTasksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Parse.listTasksStatuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellStatus = collectionView.dequeueReusableCell(withReuseIdentifier: "StatusCell", for: indexPath) as! StatusCell
        cellStatus.currentIndexFilter = currentIndexFilter
        cellStatus.indexPathRow = indexPath.row
        cellStatus.setCell(index: indexPath.row)
        
        
//        var item = Parse.listTasksSort[indexPath.row]
//        var key = Parse.listTasksStatuses[indexPath.row]
//        cellStatus.badgeLabel.text = String(item)
        
        return cellStatus
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexFilter = indexPath.row
        selectFilterTasks()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
}
