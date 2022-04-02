import Foundation
import Networking

struct HomeRequest: URLRequestProtocol {
    
    private var language: String
    private var stars: Int
    
    init(language: String, stars: Int) {
        self.language = language
        self.stars = stars
    }
    
    var baseURL: String {
        return Constants.githubBaseURL
    }
    
    var path: String {
        return "q=stars:\(self.stars)+language:\(self.language)&sort=stars&order=desc"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
