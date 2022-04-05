import Foundation
import Core
import Home
import Networking
import RepoDetails

struct RepoDetailsService: RepoDetailsServiceProtocol {

    func fetchRepositorieDetails(id: Int, completion: @escaping (Result<Repository, Error>) -> Void) {
        let request = RepoDetailsRequest(id: id)
        NetworkManager.shared.request(of: Repository.self, request: request) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
