import UIKit
import LocalAuthentication

class StartViewController: UIViewController {
    
    static let shared = StartViewController()
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
                authenticate()
    }
    
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        
                        // получение статусов задач по компании
                        //                        self?.getStatusesTaskInCompany()
                        
                        // получение задач пользователя
                        //                        self?.getTasks(offset: 0)
                        
                        //                        // получение проектов пользователя
                        //                        self?.getProjects(offset: 0)
                        
                        
                    } else {
                        // error
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            // no biometry
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    
    
    @IBAction func authenticateTapped(_ sender: Any) {
        
    }
    
    
}
