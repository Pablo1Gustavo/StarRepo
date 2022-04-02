import Foundation

public enum HTTPMethod: String {
    
    /// Defines the suported types of HTTP methods
    case post
    case put
    case get
    case delete
    case patch
    
    public var name: String {
        return rawValue.uppercased()
    }
    
}
