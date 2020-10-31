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
    
    
    func getJSON(endPoint: String, offset: Int?, limit: Int?, completion: @escaping (JSON) -> Void) {
        
        let request = "https://\(user):\(password)@\(path)/\(endPoint).json?offset=\(offset ?? 0)&limit=\(limit ?? 0)"
        
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
}
