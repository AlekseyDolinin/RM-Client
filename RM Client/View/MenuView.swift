import UIKit

class MenuView: UIView {

    @IBOutlet weak var avatarImage: UIImageView!
    
    func configure() {
        print(mainStore.state.userData?.avatar)
        avatarImage.image = mainStore.state.userData?.avatar
    }
    
}

