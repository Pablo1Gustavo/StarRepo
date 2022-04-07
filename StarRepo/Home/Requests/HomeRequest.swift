import Foundation
import Networking
import Home

struct HomeRequest: URLRequestProtocol {
    
    private var language: String
    private var sortMode: SortMode
    
    init(language: String, sortMode: SortMode) {
        self.language = language
        self.sortMode = sortMode
    }
    
    var baseURL: String {
        return "\(Constants.githubBaseURL)search/repositories"
    }
    
    var path: String? {
        return "q=language:\(self.language)&sort=stars&order=\(sortMode.rawValue)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
