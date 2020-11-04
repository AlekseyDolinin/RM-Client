import UIKit

extension UIColor {
    
    static var _backgroundDark: UIColor {return UIColor(named: #function)!}
    static var _backgroundNormal: UIColor {return UIColor(named: #function)!}
    static var _white: UIColor {return UIColor(named: #function)!}
    static var _blue: UIColor {return UIColor(named: #function)!}
    
    // Colors status
    static var _pinkStatus: UIColor {return UIColor(named: #function)!}
    static var _violetStatus: UIColor {return UIColor(named: #function)!}
    static var _orangeStatus: UIColor {return UIColor(named: #function)!}
    static var _greenStatus: UIColor {return UIColor(named: #function)!}
    static var _yellowStatus: UIColor {return UIColor(named: #function)!}

}


extension UIColor {
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
