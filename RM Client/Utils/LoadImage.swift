import UIKit
import Foundation
import SwiftyJSON
import Kingfisher

class LoadImage {
    class func get(link: String, completion: @escaping (UIImage?) -> ()) {
        
//        let urlString = link.prefix(4) == "http" ? link : (API_.shared.protocol_ + API_.hostname + link)
        
        //        let encodingURL = stringURL.encodeUrl
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
                completion (UIImage(named: "logo_frame"))
                #if DEBUG
                print("failed load image: \(error.localizedDescription)")
                #endif
            }
        }
    }
}
