import Alamofire
import SwiftyJSON

class API {
    
    static let shared = API()
    
    let user: String = UserDefaults.standard.dictionary(forKey: "userAuthData")!["user"] as! String
    let password = UserDefaults.standard.dictionary(forKey: "userAuthData")!["password"] as! String
    let server = UserDefaults.standard.dictionary(forKey: "userAuthData")!["server"] as! String
    
    func authentication(server: String, user: String, password: String, completion: @escaping (DataResponse<Any>) -> Void) {
        // проверка авторизации - получая данные по пользователю
        let request = "https://\(user):\(password)@\(server)" + "/my/account.json"
        Alamofire.request(request, method: .get).responseJSON { response in
            completion(response)
        }
    }
    
    func getJSONPagination(endPoint: String, offset: Int, limit: Int, completion: @escaping (JSON) -> Void) {
        let request = "https://\(user):\(password)@\(server)\(endPoint)offset=\(offset)&limit=\(limit)"
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
        let request = "https://\(user):\(password)@\(server)\(endPoint).json"
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
    
    func getAttachmentThumbnail(idAttachment: Int, completion: @escaping (UIImage) -> Void) {
        let request = "https://\(user):\(password)@\(server)/attachments/thumbnail/\(idAttachment)"
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
        let request = "https://\(user):\(password)@\(server)/attachments/download/\(idAttachment)"
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
    
    func getImage(link: String, completion: @escaping (UIImage) -> Void) {
        Alamofire.request(link).validate().downloadProgress { progress in
            }.response { response in
            guard let data = response.data, let image = UIImage(data: data) else {
                print("error image attachmwent")
                completion(UIImage())
                return
            }
            completion(image)
        }
    }
    
//
//    func getInfoUser(idUser: Int, completion: @escaping (JSON) -> Void) {
//        let request = "https://\(user):\(password)@\(server)" + "/users/\(idUser).json"
//        Alamofire.request(request, method: .get).responseJSON { response in
//
//            if let data = response.data {
//                let json = JSON(data)
//                let login = json["user"]["login"].stringValue
//                let email = "\(login)@\(self.server)"
//                print(email)
//            }
//
////            completion(response)
//        }
//    }
    
    
    
}
