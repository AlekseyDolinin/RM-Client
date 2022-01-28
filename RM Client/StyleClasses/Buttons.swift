import UIKit

///
class ButtonFirst: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        self.setTitleColor(._backgroundDark, for: .normal)
        self.backgroundColor = ._blue
        self.layer.cornerRadius = 4
        self.titleLabel?.font = UIFont(name: "SFCompactText-Medium", size: 16)!
    }
}

///
class ButtonClose: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        let originalImage = UIImage(named: "iconClose")
        let tintedImage = originalImage?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
//        self.tintColor = AppTheme.BB_TextPrimary
        self.imageView?.contentMode = .scaleAspectFit
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
    }
}
