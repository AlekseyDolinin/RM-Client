import UIKit

class SetServerView: UIView {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var titleInputServerLabel: UILabel!
    @IBOutlet weak var titleInputUserLabel: UILabel!
    @IBOutlet weak var titleInputPasswordLabel: UILabel!
    
    @IBOutlet weak var inputServer: UITextField!
    @IBOutlet weak var inputUser: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    
    let titleEnterButton = "ВОЙТИ"
    
    func configure() {
        
        setEnterButton()
        
        loader.stopAnimating()
        enterButton.isEnabled = false
    }
    
    func setEnterButton() {
        
        enterButton.setTitle(titleEnterButton, for: .normal)
        
        // normal
        enterButton.setTitleColor(._backgroundDark, for: .normal)
        enterButton.setBackgroundColor(._blue, for: .normal)
        
        // disabled
        enterButton.setTitleColor(._blue, for: .disabled)
        enterButton.setBackgroundColor(._backgroundNormal, for: .disabled)
    }

}
