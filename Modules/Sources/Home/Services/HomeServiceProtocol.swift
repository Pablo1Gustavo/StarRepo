import Foundation
import Core

public protocol HomeServiceProtocol {
    func fetchRepositories(searchText: String, completion: @escaping (Result<[Repository], Error>) -> Void)
}

#if DEBUG
extension DummyHomeService {
    enum CustomError: Error {
        case generic
    }
}

struct DummyHomeService: HomeServiceProtocol {
    private var state: HomeViewModel.ViewState
    
    init(state: HomeViewModel.ViewState) {
        self.state = state
    }
    
    func fetchRepositories(searchText: String, completion: (Result<[Repository], Error>) -> Void) {
        switch state {
        case .done:
            let repos = Repository.debugRepositories
            completion(.success(repos))
        case .empty:
            completion(.success([]))
        case .failure:
            completion(.failure(CustomError.generic))
        default:
            break
        }
    }
}
#endif
