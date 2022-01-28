import UIKit
import Foundation
import SwiftyJSON
import Kingfisher

class LoadImage {
    class func get(link: String, completion: @escaping (UIImage?) -> ()) {
            guard let url = URL(string: link) else {
            #if DEBUG
            print("error url load image")
            #endif
            return
        }
        UIImageView().kf.setImage(with: url,
                                  placeholder: UIImage(named: "logo_frame"),
                                  options: [.scaleFactor(UIScreen.main.scale),
                                            .transition(.fade(0.3)),
                                            .cacheOriginalImage]) { result in
            switch result {
            case .success(let value):
                completion (value.image)
            case .failure(let error):
                completion (UIImage(named: ""))
                #if DEBUG
                print("failed load image: \(error.localizedDescription)")
                #endif
            }
        }
    }
}
