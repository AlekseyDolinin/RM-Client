import UIKit

class Attach {
    
    enum type {
        case file
        case document
        case image
        case video
        
        var image: UIImage {
            switch self {
            case .file: return UIImage(named: "att_File")!
            case .document: return UIImage(named: "att_Document")!
            case .image: return UIImage(named: "att_Image")!
            case .video: return UIImage(named: "att_Video")!
            }
        }
    }
}
