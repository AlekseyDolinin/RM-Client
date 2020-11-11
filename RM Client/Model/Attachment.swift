import UIKit

class Attachment {
    
    var id: Int?
    var fileName: String?
    var createdOn: String?
    var thumbnail_url: String?
    var author: String?
    var filesize: Int?
    var description: String?
    var content_type: String?
    var content_url: String?
    var thumbnailImage: UIImage?
    
    init(id: Int? = nil,
         fileName: String? = nil,
         createdOn: String? = nil,
         thumbnail_url: String? = nil,
         author: String? = nil,
         filesize: Int? = nil,
         description: String? = nil,
         content_type: String? = nil,
         content_url: String? = nil,
         thumbnailImage: UIImage? = nil){
        
        self.id = id
        self.fileName = fileName
        self.createdOn = createdOn
        self.thumbnail_url = thumbnail_url
        self.author = author
        self.filesize = filesize
        self.description = description
        self.content_type = content_type
        self.content_url = content_url
        self.thumbnailImage = thumbnailImage
    }
}
