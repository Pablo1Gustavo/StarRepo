import Foundation
import Core
import Home

struct HomeService: HomeServiceProtocol {
    
    func fetchRepositories(searchText: String, completion: (Result<[Repository], Error>) -> Void) {
        completion(.success([]))
    }
    
}
