import Foundation

public protocol URLRequestProtocol {
    
    /// The API's base url
    var baseURL: String { get }
    
    /// Defines the endpoint we want to hit
    var path: String? { get }
    
    /// Relative to the method we want to call, that was defined with an enum above
    var method: HTTPMethod { get }
    
}
