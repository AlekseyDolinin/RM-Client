import UIKit

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (self.frame.size.width)) / self.frame.width)
    }
}
