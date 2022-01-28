import UIKit

class Attachment {
    
    var id: Int
    var fileName: String
    var createdOn: String
    var thumbnailURL: String
    var author: String
    var filesize: Int
    var description: String
    var contentType: String
    var contentURL: String
    
    init(id: Int,
         fileName: String,
         createdOn: String,
         thumbnailURL: String,
         author: String,
         filesize: Int,
         description: String,
         contentType: String,
         contentURL: String
    ){
        
        self.id = id
        self.fileName = fileName
        self.createdOn = createdOn
        self.thumbnailURL = thumbnailURL
        self.author = author
        self.filesize = filesize
        self.description = description
        self.contentType = contentType
        self.contentURL = contentURL
    }
}
