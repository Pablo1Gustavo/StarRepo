import Foundation
import Alamofire

public final class NetworkManager {
    
    public static let shared = NetworkManager()
    
    public func request<T: Decodable>(of type: T.Type = T.self, request: URLRequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(request.baseURL, method: request.method, parameters: request.params)
            .validate()
            .responseDecodable(of: type) { response in
        
                switch response.response?.statusCode {
                case 200:
                    guard let responseValue = response.value else { return }
                    completion(.success(responseValue))
                case 304:
                    completion(.failure(HTTPError.notModified))
                case 422:
                    completion(.failure(HTTPError.unprocessableEntity))
                case 503:
                    completion(.failure(HTTPError.serviceUnavailable))
                default:
                    completion(.failure(HTTPError.error("API response code untracked")))
                }
            }
    }
    
}
