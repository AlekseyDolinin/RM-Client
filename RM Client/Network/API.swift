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
            print("RESULT AUTH: \(response.result.isSuccess)")
        }
    }
    
    func getJSONPagination(endPoint: String, offset: Int?, limit: Int?, completion: @escaping (JSON) -> Void) {
        
        let request = "https://\(user):\(password)@\(path)\(endPoint).json?offset=\(offset ?? 0)&limit=\(limit ?? 0)"
//        print(request)
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
//        print(request)
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
    
    func getDataTask(endPoint: String, completion: @escaping (JSON) -> Void) {
        
        let request = "https://\(user):\(password)@\(path)\(endPoint).json?include=attachments"
//        print(request)
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
        
        let request = "https://\(user):\(password)@\(path)/attachments/thumbnail/\(idAttachment)"
//        print(request)
        
        Alamofire.request(request, method: .get).response { response in

            if let dataEncodedString = response.data {
                guard  let decodedimage = UIImage(data: dataEncodedString) else {
                    print("error decoded image")
                    
                    //если ошибка то заменяю превью заглушкой
                    completion(Attach.type.image.image)
                    return
                }                
                completion(decodedimage)
            } else {
                print("ERROR GET IMAGE")
            }
        }
    }
}
