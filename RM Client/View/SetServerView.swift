import UIKit

class SetServerView: UIView {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var inputServer: UITextField!
    @IBOutlet weak var inputAPIkey: UITextField!
    @IBOutlet weak var inputLogin: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var hideShowPassword: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var stackInputs: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        hideShowPassword.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    
    @objc func togglePasswordVisibility() {
        inputPassword.togglePasswordVisibility()
    }
    
    func lockContent() {
        loader.startAnimating()
        stackInputs.alpha = 0.3
        enterButton.isEnabled = false
        enterButton.alpha = 0.3
    }
    
    func unlockContent() {
        loader.stopAnimating()
        stackInputs.alpha = 1.0
        enterButton.isEnabled = true
        enterButton.alpha = 1.0
    }
    
    
    
//    func configure() {
//
//        enterButton.layer.cornerRadius = 4
//        enterButton.clipsToBounds = true
//
//        inputServer.attributedPlaceholder = NSAttributedString(string: "example.com",
//                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor._blue])
////        setEnterButton()
//
//        loader.stopAnimating()
////        enterButton.isEnabled = false
//    }
    
//    func setEnterButton() {
//
//        enterButton.setTitle(titleEnterButton, for: .normal)
//
//        // normal
//        enterButton.setTitleColor(._backgroundDark, for: .normal)
//        enterButton.setBackgroundColor(._blue, for: .normal)
//
//        // disabled
//        enterButton.setTitleColor(._blue, for: .disabled)
//        enterButton.setBackgroundColor(._backgroundNormal, for: .disabled)
//    }
    
    ///
    @IBAction func focusInput(_ sender: UIButton) {
        switch sender.restorationIdentifier {
        case "server":
            inputServer.becomeFirstResponder()
        case "apikey":
            inputAPIkey.becomeFirstResponder()
        case "login":
            inputLogin.becomeFirstResponder()
        case "password":
            inputPassword.becomeFirstResponder()
        default:
            break
        }
    }

}

extension SetServerView {
    func setUI() {
        setLabels()

        loader.stopAnimating()
        hideShowPassword.isHidden = true
    }
    ///
    func setLabels() {

    }
}
