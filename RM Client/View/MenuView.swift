import UIKit

class MenuView: UIView {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    func configure() {
        
        avatarImage.layer.cornerRadius = 4
        avatarImage.image = mainStore.state.userData?.avatar
        
        let lastname: String = mainStore.state.userData!.lastname!
        let firstname: String = mainStore.state.userData!.firstname!
        userFullName.text = "\(lastname) \(firstname)"
        userEmail.text = mainStore.state.userData?.mail
    }
    
}

