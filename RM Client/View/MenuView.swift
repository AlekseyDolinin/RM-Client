import UIKit

class MenuView: UIView {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImage.layer.cornerRadius = 4
        let lastname: String = Parse.user.lastname
        let firstname: String = Parse.user.firstname
        userFullName.text = "\(lastname) \(firstname)"
        userEmail.text = Parse.user.mail
        
        LoadImage.get(link: Parse.user.avatar!) { image in
            self.avatarImage?.image = image
        }
        
        print(Parse.user.avatar)
    }
    
}

