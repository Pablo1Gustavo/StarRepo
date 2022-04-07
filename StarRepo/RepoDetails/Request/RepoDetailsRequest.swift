import Foundation
import Networking

struct RepoDetailsRequest: URLRequestProtocol {
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var baseURL: String { //pega o baseURL das constants
        return "\(Constants.githubBaseURL)repositories/\(self.id)"
    }
    
    var path: String? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
