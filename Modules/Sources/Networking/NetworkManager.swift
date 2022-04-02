import Foundation

public final class NetworkManager {
    
    public static let shared = NetworkManager()
    
    public func request<T: Decodable>(of type: T.Type = T.self, request: URLRequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        if var baseURL = URLComponents(string: request.baseURL) {
            baseURL.query = request.path
            
            guard let url = baseURL.url else { return }
            
            print(url.absoluteString)
            
            var requestURL = URLRequest(url: url)
            requestURL.httpMethod = request.method.name
            
            let dataTask = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                switch httpResponse.statusCode {
                case 200:
                    do {
                        guard let data = data else { return }

                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(type, from: data)
                        
                        completion(.success(responseData))
                    } catch {
                        completion(.failure(error))
                    }
                default:
                    break
                }
            }
            
            dataTask.resume()
        }
    }
    
}
