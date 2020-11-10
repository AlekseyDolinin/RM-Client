import UIKit

class AttachmentsViewController: UIViewController {
    
    var attachmentsView: AttachmentsView! {
        guard isViewLoaded else {return nil}
        return (view as! AttachmentsView)
    }
    
    var selectTask: Task?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attachmentsView.tableAttachments.delegate = self
        attachmentsView.tableAttachments.dataSource = self
        
        for attachment in selectTask!.attachments {
            
//            print("author: \(attachment.author)")
//            print("content_type: \(attachment.content_type)")
//            print("content_url: \(attachment.content_url)")
//            print("createdOn: \(attachment.createdOn)")
//            print("description: \(attachment.description)")
//            print("fileName: \(attachment.fileName)")
//            print("filesize: \(attachment.filesize)")
//            print("id: \(attachment.id)")
//            print("thumbnail_url: \(attachment.thumbnail_url)")
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
  
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

