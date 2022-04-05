import Foundation
import Networking

struct HomeRequest: URLRequestProtocol {
    
    private var language: String
    
    init(language: String, stars: Int) {
        self.language = language
    }
    
    var baseURL: String {
        return "\(Constants.githubBaseURL)search/repositories"
    }
    
    var path: String? {
        return "q=language:\(self.language)&sort=stars&order=desc"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
