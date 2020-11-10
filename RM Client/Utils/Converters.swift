import Foundation

class Convert {
    
    class func convertByteToMb(valueByte: Int) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let stringValue = bcf.string(fromByteCount: Int64(valueByte))
        return stringValue
    }
  
}
