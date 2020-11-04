import UIKit

class StatusCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameStatus: UILabel!
    
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        backView.layer.borderWidth = 1
        
        badgeView.layer.cornerRadius = badgeView.frame.height / 2
        badgeView.layer.borderWidth = 1
        
        badgeLabel.textColor = ._white
        
        badgeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        badgeView.layer.shadowColor = UIColor._backgroundDark.cgColor
        badgeView.layer.shadowRadius = 1
        badgeView.layer.shadowOpacity = 0.75
    }
    
    class var reuseIdentifier: String {
        return "StatusCell"
    }
    
    class var nibName: String {
        return "StatusCell"
    }
    
    func configureCell(name: String) {
        nameStatus.text = name
    }

}
