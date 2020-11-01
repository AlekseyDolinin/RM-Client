import UIKit

class StatusCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        backView.layer.borderWidth = 1
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
