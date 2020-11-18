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
    
    
    func getImage(endPoint: String, completion: @escaping (Data) -> Void) {
        let request = "https://\(user):\(password)@\(server)\(endPoint)"
        Alamofire.request(request, method: .get).response { response in
            if let data = response.data {
                completion(data)
            }
        }
    }
    
    func getGlobalImage(link: String, completion: @escaping (UIImage) -> Void) {
        Alamofire.request(link, method: .get).response { response in
            if let data = response.data {
                if let image = UIImage(data: data) {
                    completion(image)
                }
            }
        }
    }
    
    func getVideo(endPoint: String, completion: @escaping (Data) -> Void) {
        let request = "https://\(user):\(password)@\(server)\(endPoint)"
        Alamofire.request(request, method: .get).response { response in
            if let data = response.data {
                completion(data)
            }
        }
    }
    
    func getPdf(link: String, completion: @escaping (URL) -> Void) {
        
 
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        print(location)
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
