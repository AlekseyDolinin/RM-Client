import Alamofire
import SwiftyJSON

class API {
    
    static let shared = API()
    
    let user = "a.dolinin"
    let password = "Nfkkby9890"
    let path = "dev.labmedia.su"
    
    // auth
    func authentication(completion: @escaping (Bool) -> Void) {
        let request = "https://\(user):\(password)@\(path)/projects.json"
        Alamofire.request(request, method: .get).responseJSON { response in
            completion(response.result.isSuccess)
        }
    }
    
    func getJSONPagination(endPoint: String, offset: Int, limit: Int, completion: @escaping (JSON) -> Void) {
        let request = "https://\(user):\(password)@\(path)\(endPoint)&include=attachments&offset=\(offset)&limit=\(limit)"
        Alamofire.request(request, method: .get).responseJSON { response in
            if response.result.isSuccess == false {
                print("ERROR GET JSON Pagination")
                return
            }
            if let data = response.data {
                let json = JSON(data)
                completion(json)
            }
        }
    }
    
    func getJSON(endPoint: String, completion: @escaping (JSON) -> Void) {
        let request = "https://\(user):\(password)@\(path)\(endPoint).json"
        Alamofire.request(request, method: .get).responseJSON { response in
            if response.result.isSuccess == false {
                print("ERROR GET JSON")
                return
            }
            if let data = response.data {
                let json = JSON(data)
                completion(json)
            }
        }
    }
    
//    func getDataTask(endPoint: String, completion: @escaping (JSON) -> Void) {
//
//        let request = "https://\(user):\(password)@\(path)\(endPoint).json?include=attachments"
//        Alamofire.request(request, method: .get).responseJSON { response in
//            if response.result.isSuccess == false {
//                print("ERROR GET JSON")
//                return
//            }
//            if let data = response.data {
//                let json = JSON(data)
//                completion(json)
//            }
//        }
//    }
    
    func getAttachmentThumbnail(idAttachment: Int, completion: @escaping (UIImage) -> Void) {
        let request = "https://\(user):\(password)@\(path)/attachments/thumbnail/\(idAttachment)"
        Alamofire.request(request, method: .get).response { response in
            DispatchQueue.main.async {
                guard let data = response.data, let image = UIImage(data: data) else {
                    print("error image Thumbnail")
                    completion(Attach.type.image.image)
                    return
                }
                completion(image)
            }
        }
    }
    
    func getAttachmentImage(idAttachment: Int, completion: @escaping (UIImage) -> Void) {
        let request = "https://\(user):\(password)@\(path)/attachments/download/\(idAttachment)"
        Alamofire.request(request).validate().downloadProgress { progress in
            
//                print("totalUnitCount:\n", progress.totalUnitCount)
//                print("completedUnitCount:\n", progress.completedUnitCount)
//                print("fractionCompleted:\n", progress.fractionCompleted)
//                print("localizedDescription:\n", progress.localizedDescription)
//                print("---------------------------------------------")
        }.response { response in
            DispatchQueue.main.async {
                guard let data = response.data, let image = UIImage(data: data) else {
                    print("error image attachmwent")
                    completion(UIImage())
                    return
                }
                completion(image)
            }
        }
    }
    
}
