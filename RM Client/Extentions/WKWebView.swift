import WebKit

class CustomWebView: WKWebView {
    override func load(_ request: URLRequest) -> WKNavigation? {
        guard let mutableRequest: NSMutableURLRequest = request as? NSMutableURLRequest else {
            return super.load(request)
        }
        mutableRequest.setValue("custom value", forHTTPHeaderField: "custom field")
        return super.load(mutableRequest as URLRequest)
    }
}
