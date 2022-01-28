import UIKit

class StatusCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameStatus: UILabel!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    
    var currentIndexFilter: Int!
    var indexPathRow: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        backView.layer.borderWidth = 1
        badgeView.layer.cornerRadius = badgeView.frame.height / 2
        badgeLabel.textColor = ._white
    }
    
    func setCell(index: Int) {
        let nameTab = Parse.listTasksStatuses[index]
        
        nameStatus.text = nameTab
        
        badgeLabel.text = String(Parse.listTasksSort[nameTab]?.count ?? 0)
        
        let currentColor = Parse.listColorsStatus[indexPathRow]
        backView.layer.borderColor = currentColor.cgColor
        badgeView.backgroundColor = currentColor.darker(by: 15)
        
        // set current Cell Status
        if indexPathRow == currentIndexFilter {
            nameStatus.textColor = ._white
            backView.backgroundColor = Parse.listColorsStatus[currentIndexFilter]
        } else {
            nameStatus.textColor = Parse.listColorsStatus[indexPathRow]
            backView.backgroundColor = .clear
        }
    }
}
