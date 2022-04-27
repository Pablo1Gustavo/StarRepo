import Foundation
import Alamofire

public protocol URLRequestProtocol {
    
    /// The endpoint url from API
    var baseURL: String { get }
    
    /// Defines the request params
    var params: [String: String]? { get }
    
    /// Relative to the method we want to call, that is part of Alamofire implementation
    var method: HTTPMethod { get }
    
}
