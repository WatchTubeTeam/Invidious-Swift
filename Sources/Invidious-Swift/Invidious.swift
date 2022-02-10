import Foundation

public struct Inv {
    public private(set) var text = "Hello, World!"
    
    public init() {
    }
    
    func setInstance(url: String) -> Void {
        
    }
    
    static func getJson(url: URL, completion: @escaping (_ value: Dictionary<String,Any>?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let d = data {
                if let value = String(data: d, encoding: String.Encoding.ascii) {
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        do {
                            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                            return completion(json)
                        } catch {
                            return completion(["error": error.localizedDescription])
                        }
                    }
                }
            }
        }.resume()
    }
}
