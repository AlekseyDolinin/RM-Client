import Alamofire
import SwiftyJSON

class API {
    
    static let shared = API()
    
    let server = UserDefaults.standard.dictionary(forKey: "userAuthData")!["server"] as! String
    let apikey = UserDefaults.standard.dictionary(forKey: "userAuthData")!["apikey"] as! String
    let login: String = UserDefaults.standard.dictionary(forKey: "userAuthData")!["login"] as! String
    let password = UserDefaults.standard.dictionary(forKey: "userAuthData")!["password"] as! String
    
    ///
    func auth(completion: @escaping (DataResponse<Any>) -> ()) {
        let headers: [String: String]? = apikey.isEmpty ? nil : ["X-Redmine-API-Key": apikey]
        let request = "https://\(login):\(password)@\(server)" + "/my/account.json"
        Alamofire.request(request, method: .get, headers: headers).responseJSON { response in
            completion(response)
        }
    }

    ///
    func getJSONPagination(endPoint: String, offset: Int, limit: Int, completion: @escaping (JSON) -> Void) {
        
        let headers: [String: String]? = apikey.isEmpty ? nil : ["X-Redmine-API-Key": apikey]
        let request = "https://\(login):\(password)@\(server)\(endPoint)offset=\(offset)&limit=\(limit)"
        
        Alamofire.request(request, method: .get, headers: headers).responseJSON { response in
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
    
    ///
    func getJSON(endPoint: String, completion: @escaping (JSON) -> Void) {
        
        let headers: [String: String]? = apikey.isEmpty ? nil : ["X-Redmine-API-Key": apikey]
        let request = "https://\(login):\(password)@\(server)\(endPoint).json"
        
        Alamofire.request(request, method: .get, headers: headers).responseJSON { response in
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
        let request = "https://\(login):\(password)@\(server)\(endPoint)"
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
        let request = "https://\(login):\(password)@\(server)\(endPoint)"
        Alamofire.request(request, method: .get).response { response in
            if let data = response.data {
                completion(data)
            }
        }
    }
    
    func getPdf(link: String, completion: @escaping (Data) -> Void) {
        Alamofire.request(link, method: .get).response { response in
            guard let pdfData = response.data else {
                print("error pdf data")
                return
            }
            completion(pdfData)
        }
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
