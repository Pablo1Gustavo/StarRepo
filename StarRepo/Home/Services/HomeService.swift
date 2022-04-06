import Foundation
import Core
import Home
import Networking

struct HomeService: HomeServiceProtocol {

    func fetchRepositories(searchText: String, sortMode: SortMode, completion: @escaping (Result<[Repository], Error>) -> Void) {
        let request = HomeRequest(language: searchText, sortMode: sortMode)
        NetworkManager.shared.request(of: RepositoriesResponse.self, request: request) { result in
            switch result {
            case .success(let result):
                completion(.success(result.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
